mysql:Client mysqlClient = check new (user = "root", password = "Test@123", database = "CUSTOMER",
                                      options = {useXADatasource: true});