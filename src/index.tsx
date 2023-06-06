import createEngine, {
	DiagramModel,
	DefaultNodeModel,
	DefaultPortModel,
	NodeModel,
	DagreEngine,
	DiagramEngine,
	PathFindingLinkFactory
} from '@projectstorm/react-diagrams';
import * as React from 'react';
import ReactDOM from "react-dom";
import './helpers/index.css';
import { DemoButton, DemoWorkspaceWidget } from './helpers/DemoWorkspaceWidget';
import { CanvasWidget } from '@projectstorm/react-canvas-core';
import { DemoCanvasWidget } from './helpers/DemoCanvasWidget';
import axios from 'axios';



function createNode(name): any {
	return new DefaultNodeModel(name, 'rgb(0,192,255)');
}

class DemoWidget extends React.Component<{ model: DiagramModel; engine: DiagramEngine }, any> {
	engine: DagreEngine;

	constructor(props) {
		super(props);
		this.engine = new DagreEngine({
			graph: {
				rankdir: 'RL',
				ranker: 'longest-path',
				marginx: 25,
				marginy: 25
			},
			includeLinks: true,
			nodeMargin: 25
		});
	}

	autoDistribute = () => {
		this.engine.redistribute(this.props.model);

		// only happens if pathfing is enabled (check line 25)
		this.reroute();
		this.props.engine.repaintCanvas();
	};

	autoRefreshLinks = () => {
		this.engine.refreshLinks(this.props.model);

		// only happens if pathfing is enabled (check line 25)
		this.reroute();
		this.props.engine.repaintCanvas();
	};
	componentDidMount(): void {
		setTimeout(() => {
			this.autoDistribute();
		}, 500);
	}

	reroute() {
		this.props.engine
			.getLinkFactories()
			.getFactory<PathFindingLinkFactory>(PathFindingLinkFactory.NAME)
			.calculateRoutingMatrix();
	}

	render() {
		return (
			<DemoWorkspaceWidget
				buttons={
					<div>
						<DemoButton onClick={this.autoDistribute}>Re-distribute</DemoButton>
						<DemoButton onClick={this.autoRefreshLinks}>Refresh Links</DemoButton>
					</div>
				}
			>
				<DemoCanvasWidget>
					<CanvasWidget engine={this.props.engine} />
				</DemoCanvasWidget>
			</DemoWorkspaceWidget>
		);
	}
}

var sampleSchema = {
    customers: {
        columns: {
            customerNumber: "int",
            customerName: "varchar",
            contactLastName: "varchar",
            contactFirstName: "varchar",
            phone: "varchar",
            addressLine1: "varchar",
            addressLine2: "varchar",
            city: "varchar",
            state: "varchar",
            postalCode: "varchar",
            country: "varchar",
            salesRepEmployeeNumber: "int",
            creditLimit: "decimal"
        },
        tableKeys: [
            {
                columnName: "salesRepEmployeeNumber",
                constraintName: "customers_ibfk_1",
                referencedTableName: "employees",
                referencedColumnName: "employeeNumber"
            },
            {
                columnName: "customerNumber",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            }
        ]
    },
    employees: {
        columns: {
            employeeNumber: "int",
            lastName: "varchar",
            firstName: "varchar",
            extension: "varchar",
            email: "varchar",
            officeCode: "varchar",
            reportsTo: "int",
            jobTitle: "varchar"
        },
        tableKeys: [
            {
                columnName: "reportsTo",
                constraintName: "employees_ibfk_1",
                referencedTableName: "employees",
                referencedColumnName: "employeeNumber"
            },
            {
                columnName: "officeCode",
                constraintName: "employees_ibfk_2",
                referencedTableName: "offices",
                referencedColumnName: "officeCode"
            },
            {
                columnName: "employeeNumber",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            }
        ]
    },
    offices: {
        columns: {
            officeCode: "varchar",
            city: "varchar",
            phone: "varchar",
            addressLine1: "varchar",
            addressLine2: "varchar",
            state: "varchar",
            country: "varchar",
            postalCode: "varchar",
            territory: "varchar"
        },
        tableKeys: [
            {
                columnName: "officeCode",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            }
        ]
    },
    orderdetails: {
        columns: {
            orderNumber: "int",
            productCode: "varchar",
            quantityOrdered: "int",
            priceEach: "decimal",
            orderLineNumber: "smallint"
        },
        tableKeys: [
            {
                columnName: "orderNumber",
                constraintName: "orderdetails_ibfk_1",
                referencedTableName: "orders",
                referencedColumnName: "orderNumber"
            },
            {
                columnName: "productCode",
                constraintName: "orderdetails_ibfk_2",
                referencedTableName: "products",
                referencedColumnName: "productCode"
            },
            {
                columnName: "orderNumber",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            },
            {
                columnName: "productCode",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            }
        ]
    },
    orders: {
        columns: {
            orderNumber: "int",
            orderDate: "date",
            requiredDate: "date",
            shippedDate: "date",
            status: "varchar",
            comments: "text",
            customerNumber: "int"
        },
        tableKeys: [
            {
                columnName: "customerNumber",
                constraintName: "orders_ibfk_1",
                referencedTableName: "customers",
                referencedColumnName: "customerNumber"
            },
            {
                columnName: "orderNumber",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            }
        ]
    },
    payments: {
        columns: {
            customerNumber: "int",
            checkNumber: "varchar",
            paymentDate: "date",
            amount: "decimal"
        },
        tableKeys: [
            {
                columnName: "customerNumber",
                constraintName: "payments_ibfk_1",
                referencedTableName: "customers",
                referencedColumnName: "customerNumber"
            },
            {
                columnName: "checkNumber",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            },
            {
                columnName: "customerNumber",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            }
        ]
    },
    productlines: {
        columns: {
            productLine: "varchar",
            textDescription: "varchar",
            htmlDescription: "mediumtext",
            image: "mediumblob"
        },
        tableKeys: [
            {
                columnName: "productLine",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            }
        ]
    },
    products: {
        columns: {
            productCode: "varchar",
            productName: "varchar",
            productLine: "varchar",
            productScale: "varchar",
            productVendor: "varchar",
            productDescription: "text",
            quantityInStock: "smallint",
            buyPrice: "decimal",
            MSRP: "decimal"
        },
        tableKeys: [
            {
                columnName: "productCode",
                constraintName: "PRIMARY",
                referencedTableName: null,
                referencedColumnName: null
            },
            {
                columnName: "productLine",
                constraintName: "products_ibfk_1",
                referencedTableName: "productlines",
                referencedColumnName: "productLine"
            }
        ]
    }
};


function getPortLabelForColumn(graphData, tableName, columnName) {
    let table = graphData[tableName];
    let columns = table["columns"];
    let portLabel = `${columns[columnName]}: ${columnName}`;
    return portLabel;
}


function createNodeFromTableSchema(graphData, tableName, columns, tableKeys) {
	let node = createNode(tableName);

	// Add ports (column names and data types) to this database table node.
	const columnNames = Object.keys(columns);
	columnNames.forEach((columnName, index) => {
		let tableKey = tableKeys.filter(obj => {
			return obj.columnName === columnName
		});
		
		// Add port, determining port direction by whether or not there are 
		// foreign key constraints associated with the column. 
		// let portLabel = `${columns[columnName]}: ${columnName}`;
        let portLabel = getPortLabelForColumn(graphData, tableName, columnName);
        console.log("Port label: " + portLabel);
		if (Object.entries(tableKey).length <1) {
			node.addInPort(portLabel);
		} else {
			if (tableKey[0]["referencedTableName"] == null) {
				node.addInPort(portLabel);
			} else {
				node.addOutPort(portLabel);
			}
		}
	});

	return node;
}


function linkTableNodesFromSchema(graphData, tableNodes) {
	// Walk through constraint data for each table, looking for foreign key
	// relationships to create links from.  Generate a link array for the model.
    let links = [];

    for (let tableName in graphData) {
        let table = graphData[tableName];

        console.log("In linker (tableName loop).  TableName: " + tableName);
        let tableKeys = [];
        if (table.hasOwnProperty("tableKeys")) {
            tableKeys = table.tableKeys;
        }
        tableKeys.forEach((tableKey)=>{
            if (tableKey.referencedTableName != null) {
                let toNode = tableNodes.filter(obj=> {
                    return obj.getOptions().name === tableKey.referencedTableName
                })[0];
                let toPortLabel = getPortLabelForColumn(graphData, tableKey.referencedTableName, tableKey.referencedColumnName);
                let toPort = toNode.getPort(toPortLabel);

                let fromNode = tableNodes.filter(obj=> {
                    return obj.getOptions().name === tableName
                })[0];
                let fromPortLabel = getPortLabelForColumn(graphData, tableName, tableKey.columnName);
                let fromPort = fromNode.getPort(fromPortLabel);

                let linkLabel = tableKey.constraintName;
                let link = fromPort.link(toPort);
                link.addLabel(linkLabel);

                links.push(link);
            }
        });
    }

    return links;
}

function generateGraph(graphData) {
    let model = new DiagramModel();
	let tableNodes: NodeModel[] = [];

	// First pass generates nodes based on table data
	for (let tableName in graphData) {
        let table = graphData[tableName];
		let tableKeys = [];
		let columns = {};
        if (table.hasOwnProperty("columns")) {
            columns = table.columns;
        } else {
            console.log("ERROR: 'columns' key not in table entry");
        }
        if (table.hasOwnProperty("tableKeys")) {
            tableKeys = table.tableKeys;
        } else {
            tableKeys = [];
        }
		let node = createNodeFromTableSchema(graphData, tableName, columns, tableKeys);
		tableNodes.push(node);
    }

	// second pass generates links between nodes created in pass one.
	let links = linkTableNodesFromSchema(graphData, tableNodes);

	tableNodes.forEach((node, index) => {
		node.setPosition(index * 70, 100);
		model.addNode(node);
	});

	links.forEach((link) => {
		model.addLink(link);
	});

    return model;
}


function SchemaDiagram() {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const schemaName = urlParams.get('schema');
    console.log("SCHEMA: " + schemaName);

	let engine = createEngine();
    const rootElement = document.getElementById("root");

    let schemaUrl = `http://localhost:3001/schema?schema=${schemaName}`;
    axios
    .get(schemaUrl)
    .then((response) => {
        let model : DiagramModel = generateGraph(response.data);
        engine.setModel(model);

        ReactDOM.render(<DemoWidget model={model} engine={engine} />, rootElement);    
    })
    .catch((ex) => {
      let error = axios.isCancel(ex)
        ? 'Request Cancelled'
        : ex.code === 'ECONNABORTED'
        ? 'A timeout has occurred'
        : ex.response.status === 404
        ? 'Resource Not Found'
        : 'An unexpected error has occurred';
        console.log(error);
    });
}

  
SchemaDiagram();
