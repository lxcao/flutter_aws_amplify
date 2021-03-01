const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:eca32fd7-b752-4b44-a87b-e088af6055f4",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_bc39xsCza",
                        "AppClientId": "3q26en6ie2l8is439prjks9cm9",
                        "AppClientSecret": "1v3pjf9sdupi6r5mqu3ub23fgk73hsqnpb101grak45dua10it5v",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "flutterawsamplify0e2e134a222e4ba2b850f8220c0d34104231-dev",
                        "Region": "us-east-1"
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "ffd0d89d0f2f4adaaa5a3001cf8c3bdb",
                        "Region": "us-east-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "us-east-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "flutterawsamplify0e2e134a222e4ba2b850f8220c0d34104231-dev",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            }
        }
    },
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "ffd0d89d0f2f4adaaa5a3001cf8c3bdb",
                    "region": "us-east-1"
                },
                "pinpointTargeting": {
                    "region": "us-east-1"
                }
            }
        }
    }
}''';