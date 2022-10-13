from pymongo import MongoClient


from pymongo.collection import Collection
from pymongo.database import Database

client:MongoClient = MongoClient()

db_testifcancreate:Database = client["testifcancreate"]
print(client)
print(db_testifcancreate)

db_testifcancreate_collection_neh:Collection = db_testifcancreate["neh"]

db_testifcancreate_collection_neh.insert_one( { "somefield" : "from python server to be deleted"})
db_testifcancreate_collection_neh.insert_one( { "somefield" : "from python server to be deleted 2"})
db_testifcancreate_collection_neh.insert_one( { "somefield" : "from python server   24ioyq3roiqywr dsf"})
db_testifcancreate_collection_neh.insert_one( { "somefield" : "from python server"})

db_testifcancreate_collection_neh.count_documents({})

# what = db_testifcancreate_collection_neh.delete_many( { })
what = db_testifcancreate_collection_neh.delete_many( { "somefield" : "from python server to be deleted"})
what = db_testifcancreate_collection_neh.delete_many( { "somefield" : { "$regex" : "from python server to be deleted"}})

print(what)
