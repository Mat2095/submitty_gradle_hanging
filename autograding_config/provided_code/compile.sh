export GRADLE_USER_HOME=/tmp/.gradle
export GRADLE_OPTS="-Xms2g -Xmx4g -XX:MaxMetaspaceSize=2g"
./gradlew assemble --console=plain --offline --no-daemon
