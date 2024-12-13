FROM cbioportal/cbioportal:5.4.2

# abort early if a command exits with non-zero status code.
RUN set -eu

# requests uses its own cert bundle, so we need to point it to the system cert bundle.
ENV REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

# validateData.py needs a patch so that api tokens can be passed into it.
COPY scripts/validateData.py /cbioportal/core/src/main/scripts/importer/validateData.py
# copy ukl intermediate cert to user certificate dir.
COPY certs/*.crt /usr/local/share/ca-certificates/

# apply correct file permissions.
RUN chmod 0644 /usr/local/share/ca-certificates/*.crt && \
    # update system cert bundle.
	update-ca-certificates && \
    # import ukl intermediate cert into the jvm trust store.
	keytool -importcert -alias UKLRootCA-2016 -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/UKLRootCA-2016.crt -noprompt
