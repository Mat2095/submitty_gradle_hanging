FROM submitty/java:11

# fix missing locale warning
RUN apt-get update && apt-get install -y locales && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

# create untrusted users since some tools (like whoami) cause problems if the UIDs don't exist
RUN apt-get update && apt-get install -y python3
COPY create_untrusted_users.py /
RUN python3 create_untrusted_users.py && rm -f create_untrusted_users.py

# run gradle on initial code to automatically download all required files from the internet
COPY submission /tmp/code_setup
RUN cd /tmp/code_setup \
    && export GRADLE_USER_HOME=/tmp/.gradle \
    && export GRADLE_OPTS="-Xms2g -Xmx4g -XX:MaxMetaspaceSize=2g" \
    && ./gradlew assemble --console=plain --no-daemon
RUN find /tmp/.gradle/ -name "*.lock" -type f -delete \
    && find /tmp/.gradle/ -name "gc.properties" -type f -delete \
    && chmod -R a+rw /tmp/.gradle
