import zmq
(public, secret) = zmq.curve_keypair()

print(public.decode('UTF-8'))
print(secret.decode('UTF-8'))