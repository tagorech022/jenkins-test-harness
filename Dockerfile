# Step 1: Ensure you're in the correct directory
cd /path/to/your/plugin/project

# Step 2: Build the plugin
mvn clean install

# Step 3: Ensure the .hpi file exists
ls target/workflow-job.hpi

# Step 4: Ensure plugins.txt exists (or create it if not needed)
touch plugins.txt  # Or add actual plugin list

# Step 5: Build the Docker image
docker build -t tagore405/jenkins-test-harness .
