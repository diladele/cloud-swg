openssl req -x509 \
	-nodes -days 1825 \
		-newkey rsa:2048 \
			-keyout console.key \
			-out console.crt \
			-subj "/C=NL/ST=Noord-Holland/O=Example Ltd./OU=IT/CN=console.example.com/emailAddress=support@example.com"