import * as session from 'express-session';
import * as express from 'express';
import * as AWS from 'aws-sdk';

export = connect_dynamodb;

declare function connect_dynamodb(connect: (options?: session.SessionOptions) => express.RequestHandler): any;

declare namespace connect_dynamodb {

  // tslint:disable-next-line
  export interface configOptions {
    // Optional DynamoDB table name, defaults to 'sessions'
    table?: string;

    // Optional path to AWS credentials and configuration file
    AWSConfigPath?: string;

    // Optional JSON object of AWS credentials and configuration
    AWSConfigJSON?: {
      accessKeyId: string,
      secretAccessKey: string,
      region: string,
    };
    // Optional client for alternate endpoint, such as DynamoDB Local
    client?: AWS.DynamoDB.DocumentClient;

    // Optional ProvisionedThroughput params, defaults to 5
    readCapacityUnits?: number;
    writeCapacityUnits?: number;
  }

  // tslint:disable-next-line
  function DynamoDBStore(options?: configOptions): void;

  const prototype: {};

}
