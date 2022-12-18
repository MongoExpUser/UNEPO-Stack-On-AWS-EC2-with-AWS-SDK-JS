/*
#  *****************************************************************************************************************************************************
#  *                                                                                                                                                   *
#  * @License Starts                                                                                                                                   *
#  *                                                                                                                                                   *
#  * Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.                                                                                   *
#  *                                                                                                                                                   *
#  * License: MIT -https://github.com/MongoExpUser/UNEPO-Stack-On-EC2-with-AWS-SDK-JS/blob/main/LICENSE                                                *
#  *                                                                                                                                                   *
#  * @License Ends                                                                                                                                     *
#  *****************************************************************************************************************************************************
#  *                                                                                                                                                   *
#  *  index.js implements a module/scrip for the deploying/creating or deleting of resources, including:                                               *
#  *                                                                                                                                                   *
#  *  1) AWS EC2 instance(s) with Ubuntu 22.04 LTS OS                                                                                                  *
#  *                                                                                                                                                   *
#  *  2) Bash launch/start-up script (user data) for the installation of software, on the instance(s), including:                                      *
#  *     Additional Ubuntu OS packages; NodeJS; ExpressJS web server framework; other Node.js packages; and PostgreSQL.                                *
#  *                                                                                                                                                   *                                                                                                                                                  *
#  *****************************************************************************************************************************************************
*/


class UNEPOStack
{
    constructor()
    {
      return null;
    }
    
    async createDelete(paramsObject=null)
    {
        const EC2 = require('aws-sdk/clients/ec2');
        let options =  paramsObject.credentials;
        const ec2Client = new EC2(options=options);
        const runInstancesParams = paramsObject.createParameters;
        const terminateInstancesParams = paramsObject.deleteParameters;
        const line = UNEPOStack.separator();
        let runInstancesData;
        
        if(paramsObject.createResources === true)
        {
            ec2Client.runInstances(runInstancesParams, function(runInstancesError,  runInstancesData)
            {
                if(runInstancesError)
                {
                  return console.log(runInstancesError);
                }
                     
                console.log(runInstancesData);
                    
                UNEPOStack.separator();
                console.log(`Successfully created AWS EC2 Instance.`);
                UNEPOStack.separator();
                console.log(`Time is:`, new Date(), `.....`);
                UNEPOStack.separator();
            });
        }
        else
        {
            if(paramsObject.deleteResources === true)
            {
              
              ec2Client.terminateInstances(terminateInstancesParams, function(terminateInstancesError, terminateInstancesData)
              {
                  if(terminateInstancesError)
                  {
                    return console.log(terminateInstancesError);
                  }
                   
                  console.log(terminateInstancesData);
                  line;
                  console.log(`Successfully deleted AWS EC2 Instance.`);
                  line;
                  console.log(`Time is:`, new Date(), `.....`);
                  line;
              });
            }
        }
    }
    
    async getUNEPOUserData(userDataFilePath, fs)
    {
        return fs.readFileSync(userDataFilePath,  {encoding: 'base64'});
    }

    static async separator()
    {
      console.log(`---------------------------------------------------------------------------------`);
    }
}


async function main()
{
    // require/import and instantiate relevant odules
    const fs = require('fs');
    const { v4: uuidv4 }  = require('uuid');
    const ups = new UNEPOStack();
    
    // read credentials, config files and user-data files
    const credentialJsonFilePath = "credentials.json";
    const inputConfigJsonFilePath = "inputConfig.json";
    const userDataFilePath = "user-data.sh";
    const credentials =  (JSON.parse(fs.readFileSync(credentialJsonFilePath))).credentials;
    const inputConfig = JSON.parse(fs.readFileSync(inputConfigJsonFilePath));
    
    // define common naming, tagging and environmental variables
    const suffix = String(uuidv4()).substring(0, 3);
    const orgName = inputConfig.orgName;
    const projectName = inputConfig.projectName;
    const environment  = inputConfig.environment;
    const regionName = inputConfig.regionName;
    const preOrPostFix = `${orgName}-${environment}`;
    const resoureName = inputConfig.resoureName;
    const creditTagOne = inputConfig.creditTagOne;
    const creator = inputConfig.creator;
    const tags = [
      { Key: "region", Value: regionName },
      { Key: "environment", Value: environment },
      { Key: "project", Value: projectName },
      { Key: "creator", Value: creator },
      { Key: "map-dba", Value: creditTagOne }
    ];
    
    //add naming tags with uuid-generared substring suffix for uniqueness
    tags.push( { Key: "Name", Value: `${preOrPostFix}-${resoureName}-${suffix}` } );
    tags.push( { Key: "name", Value: `${preOrPostFix}-${resoureName}-${suffix}` } );
    
    //define parameters
    const paramsObject = {
        credentials : credentials,
        createParameters : inputConfig.createParameters,
        deleteParameters : inputConfig.deleteParameters,
        createResources : inputConfig.createResources,
        deleteResources : inputConfig.deleteResources
    }
    
    try
    {
        //add "UserData" and "TagSpecifications" to the "createParameters" variable on the "paramsObject" object.
        paramsObject.createParameters.UserData = await ups.getUNEPOUserData(userDataFilePath, fs);
        paramsObject.createParameters.TagSpecifications = [ { "ResourceType" : "instance", "Tags": tags}, { "ResourceType" : "volume", "Tags": tags} ];

        //finally, create or delete UNEPO hardware/vm and install software
        await ups.createDelete(paramsObject);
    }
    catch (error)
    {
        return console.log("Error", error);
    }
}


main();
