# #!/usr/bin/env python

"""Client using the threading API."""
import json
import ssl
from websockets.sync.client import connect

ssl_cert = "E-IMZO.pem"

ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
ssl_context.load_verify_locations(cafile=ssl_cert)
ssl_context.verify_mode = ssl.CERT_REQUIRED


payload = {
        "plugin": "pfx",
        "name": "list_certificates",
        "arguments": [
            "/media/DSKEYS/"  # your disk variable here
        ]
    }

message = {
        "action": "callFunction",
        "data": payload
    }

def hello():
    with connect(uri="ws://localhost:64646") as websocket:
        websocket.send(json.dumps(payload))
        message = websocket.recv()
        print("message from server" , message)


if __name__ == "__main__":
    hello()



# from websocket import create_connection

# # Replace with your websocket URL
# ws_url = "ws://localhost:64646"

# try:
#     ws = create_connection(ws_url)

#     # Prepare your callFunction payload like in JS
#     payload = {
#         "plugin": "pfx",
#         "name": "list_certificates",
#         "arguments": [
#             "/media/DSKEYS/"  # your disk variable here
#         ]
#     }

#     # The JS call is like CAPIWS.callFunction({ ... }, success, error)
#     # Here we might need to wrap that in an envelope/message the server expects.
#     # Let's assume the server expects a JSON with an "action" field for callFunction:

#     message = {
#         "action": "callFunction",
#         "data": payload
#     }

#     ws.send(json.dumps(message))

#     # Receive response from server
#     response = ws.recv()
#     data = json.loads(response)
#     print("Response:", data)

#     ws.close()

# except Exception as e:
#     print("Error:", e)
