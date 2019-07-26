import zmq
(public, secret) = zmq.curve_keypair()

print("public: "+public.decode('UTF-8'))
print("private: "+ secret.decode('UTF-8'))