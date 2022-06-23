# Install Order

- Java Setup

  - Debug
    git clone git@github.com:microsoft/java-debug.git
    cd java-debug/
    ./mvnw clean install

  - Test
    git clone git@github.com:microsoft/vscode-java-test.git
    cd vscode-java-test
    npm install
    npm run build-plugin
