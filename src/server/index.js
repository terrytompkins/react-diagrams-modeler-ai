const { create } = require('domain');
const express = require('express');
const mysql2 = require('mysql2');

const app = express();
const port = 3001;

var schema_doc = {};

function createConnection(database) {
	  return mysql2.createConnection({
		host: process.env.MYSQL_HOST,
		user: process.env.MYSQL_USER,
		password: process.env.MYSQL_PASSWORD,
		database: database
	  });
	}


function handleDisconnect() {
  db.connect(function(err) {
	if(err) {
	  console.log('error when connecting to db:', err);
	  setTimeout(handleDisconnect, 2000);
	}
  });
  
  db.on('error', function(err) {
	console.log('db error', err);
	if(err.code === 'PROTOCOL_CONNECTION_LOST') { 
	  handleDisconnect();                         
	} else {                                      
	  throw err;                                  
	}
  });
}


// Connect to the database
const db = createConnection(process.env.MYSQL_DATABASE);
db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database: ', err);
  } else {
    console.log('Connected to the MySQL database.');
  }
});


// Asyncronous function to read the schema of the database
const readSchema = async () => {
	schema_doc = {};

	try {
		console.log('Reading schema...');
		// Get all table names in the schema by reading from information_schema.tables
		const [tables] = await db.promise().query('SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_SCHEMA = ?', [process.env.MYSQL_DATABASE]);

		// iterate over each table
		for (const table of tables) {
		// tables.forEach(async (table) => {
			const tableName = table.TABLE_NAME;
			schema_doc[tableName] = {};

			// Get all column names and types in the table by reading from information_schema.columns
			const [columns] = await db.promise().query('SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?', [process.env.MYSQL_DATABASE, tableName]);
			schema_doc[tableName]['columns'] = {};
			columns.forEach((column) => {
				schema_doc[tableName]['columns'][column.COLUMN_NAME] = column.DATA_TYPE;
			});
						
			// Get all key/constraint information in the table by reading from information_schema.key_column_usage
			const [keys] = await db.promise().query('SELECT COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME FROM information_schema.key_column_usage WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?', [process.env.MYSQL_DATABASE, tableName]);
			schema_doc[tableName]['tableKeys'] = [];
			keys.forEach((key) => {
				var keyObj = {};
				keyObj['columnName'] = key.COLUMN_NAME;
				keyObj['constraintName'] = key.CONSTRAINT_NAME;
				keyObj['referencedTableName'] = key.REFERENCED_TABLE_NAME || null;
				keyObj['referencedColumnName'] = key.REFERENCED_COLUMN_NAME || null;
				schema_doc[tableName]['tableKeys'].push(keyObj);
			}
			);
			console.log(JSON.stringify(schema_doc, null, 4));
		}
		console.log(JSON.stringify(schema_doc, null, 4));
	} catch (err) {
		console.log(err);
	}
};


  // app.get('/schema/:schema', async (req, res) => {
  app.get('/schema', async (req, res) => {
	// const schema = req.params.schema;
	const schema = "classicmodels";

	readSchema().then(() => {
		console.log(JSON.stringify(schema_doc, null, 4));
		res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000');
		res.json(schema_doc);
	}).catch((err) => {
		console.log(err);
		res.json({ error: err.message });
	});
  });
  



app.get('/', (req, res) => {
  res.send('Hello from Express.js!');
});


// Create an endpoint to query the database's schema
app.get('/logschema', (req, res) => {
	  db.query('SHOW TABLES', (err, rows) => {
		if (err) {
		  console.error('Error connecting to the database: ', err);
		  res.send('Error connecting to the database: ', err);
		} else {
		  console.log('Data received from the database:\n');
		  console.log(rows);
		  // for each table found, get the columns
		  rows.forEach(async (table) => {
			const [columns, fields] = await db.promise().query(`SHOW COLUMNS FROM ${table.Tables_in_classicmodels}`);
			console.log(columns);
			// console.log(fields);
		  });

		  res.send(rows);
		}
	  });
	});


app.get('/db', (req, res) => {
	  db.query('SELECT * FROM customers', (err, rows) => {
		if (err) {
		  console.error('Error connecting to the database: ', err);
		  res.send('Error connecting to the database: ', err);
		} else {
		  console.log('Data received from the database:\n');
		  console.log(rows);
		  res.send(rows);
		}
	  });
	});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

