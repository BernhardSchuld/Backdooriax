# Base image
FROM library/ubuntu:18.10

# Maintainer
MAINTAINER Bernhard Schuld <u10297902@tuks.co.za>

# Updating repositories.
RUN apt-get clean
RUN apt-get update

# Install nmap
RUN apt-get install -y nmap

# Install curl
RUN apt-get update && apt-get install -y curl

# Install gnupg
RUN apt-get install -y gnupg

# Install Metasploit
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
RUN chmod 755 msfinstall
RUN ./msfinstall

# Set Workdir
WORKDIR /opt/metasploit-framework


# Get source
COPY . .

# Entrypoint
ENTRYPOINT ["bash", "entrypoint.sh"]

# Command
# CMD ["tail", "-F", "/var/log/syslog", "/var/log/cron.log"]
