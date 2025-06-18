# Al Lizaso STEP-2 Program Week 1 Log

## Monday 06/16
* 9:18AM: Continued working on my [domain-lookup.sh](./domain-lookup.sh) script. Checked emails, calendar, etc.
* 9:48: Finished updating the comma-separated list portion of my shell script. Going to work on a project with [Puppet](https://www.puppet.com/docs/puppet/7/puppet_language.html) to get a better idea of how it works
  * What is Puppet? Puppet is a tool that helps you manage and automate the configuration of servers. When you use Puppet, you define the desired state of the systems in your infrastructure that you want to manage. You can do this by writing infrastructure code in Puppet's Domain-Specific Language (DSL) - Puppet code - which you can use with a wide array of devices and operating systems. Puppet code is declarative, which means you describe the desired state of your systems, not the steps needed to get there. Puppet then automates the process of getting these systems into that state and keeping them there. Puppet does through Puppet primary server and a Puppet agent. The Puppet primary server is the server that stores the code defining your desired state. The Puppet agent translates your code into commands then executes it on the systems you specify, in what is called a Puppet run
  * Key concepts behind Puppet: Puppet is built on the concept of infrastructure-as-code, which is the practice of treating infrastructure as if it were code. This concept is the foundation of DevOps - the practice of combining software development and operations. Treating infrastructure as code means system admins adopt practices that are traditionally associated with software developers, such as version control, peer review, automated testing, and continuous delivery. These practices that test code are effectively testing your infrastructure. When you get further along in your automation journey, you can choose to write your own unit and acceptance tests - these validate that your code, your infrastructure changes, do as you expect
  * A key feature of Puppet is idempotency - the ability to repeatedly apply code to guarantee a desired state on a system, with the assurance that you will get the same result every time. Idempotency is waht allows Puppet to run continuously. It ensures that the state of the infrastructure always matches the desired state. If a system state changes from what you describe, Puppet will bring it back to where it is meant to be. It also means that if you make a change to your desired state, your entire infrastructure will automatically update to match
  * When adopting a tool like Puppet, you will be more successful with an agile methodology in mind - working in incremental units of work and reusing code. Trying to do too much at once is a common pitfall. The more familliar you get with Puppet, the more you can scale, and the more you get used to agile methodology, the more you can democratize work. When you share a common methodology, a common pipeline, and a common language (the Puppet language) with your colleagues, your organization becomes more efficient at getting changes deployed quickly and safely
  * Git is a version control system that tracks changes in code. It is highly recommended that you store your Puppet code in a Git repository. Git is the industry standard for version control, and using it will help your team gain the benefits of the DevOps and agile methodologies. You will likely have multiple Git branches - feature branches for developing and testing code, and a production branch for releasing code. This process is known as Git flow
  * The Puppet platform: Puppet is made up of several packages, including `puppetserver`, `puppetdb`, and `puppet-agent` - which includes Facter and Hiera. Puppet is configured in an agent-server architecture, in which a primary node (system) controls configuration infromation for one or more managed agent nodes. Servers and agents communicate by HTTPS using SSL certificates. Puppet includes a built-in certificate authority for managing certificates. Puppet Server performs the role of the primary node and also runs an agent to configure itself
  * Facter, Puppet's inventory tool, gathers facts about an agent node such as its hostname, IP address, and operating system. The agent sends these facts to the primary server in the form of a special Puppet code file called a manifest. This is the information the primary server uses to compile a catalog - a JSON document describing the desired state of a specific agent node. Each agent requests and receives its own individual catalog and then enforces that desired state on the node it's running on. In this way, Puppet applies changes all across your infrastructure, ensuring that each node matches the state you defined with your Puppet code. Te agent sends a report back to the primary server
  * You keep nearly all of your Puppet code, such as manifests, in modules. Each module manages a specific task in your infrastructure, such as installing and configuring a piece of software. Modules contain both code and data. The data is what allows you to customize your configuration. Using a tool called Hiera, you can separate the data from the code and place it in a centralized location. This allows you to specify guardrails and define known paramteres and variations, so that your code is fully testable and you can validate all the edge cases of your parameters. If you have just joined an existing team that uses Puppet, take a look at how they organize their Hiera data
  * All of teh data generated by Puppet (facts, catalogs, reports) is stored in the Puppet database (Puppet DB). Storing data in PuppetDB allows Puppet to work faster and provides an API for other applications to access Puppet's collected data. When PuppetDB is full of your data, it becomes a great tool for infrastructure discovery, compliance reporting, vulnerability assessment, and more. You perform all these tasks with PuppetDB queries
  * Using Puppet code: Puppet code is stored in modules. If you are new to Puppet or want to save time, use the pre-built and tested modules on the Puppet Forge - a repository of thousands of modules made by Puppet developers and the Puppet community. Modules manage specific tasks in your infrastructure, such as installing and configuring a piece of software. Modules contain both code and data. The data is what allows you to customize your configuration. Using a tool called Hiera, you can separate the data from the code and place it in a centralized location. This allows you to specify guardrails and define known parameters and variations, so that your code is fully testable and you can validate all the edge cases of your parameters
  * The Puppet language: Puppet's declarative language is used to describe the desired state of a system. Manifest files describe how the network and operating system resources, such as files, packages, and services, should be configured. Puppet then compiles those manifests into catalogs, and applies each catalog to its corresponding node to ensure the node is configured correctly, across your infrastructure. Several parts of the Puppet language depend on evaluation order. For example, variables must be set before they are referenced
  * The following overview covers some of the key components of the Puppet language, including catalogs, resources, classes, and manifests:
    * Catalogs: To configure nodes, the primary Puppet server compiles configuration information into a catalog, which describes the desired state of a specific agent node. Each agent requests and receives its own individual catalog. The catalog describes the desired state for every resource managed on a single given node. Whereas a manifest can contain conditional logic to describe specific resource configuration for multiple nodes, a catalog is a static document that describes all of the resources and dependencies for only one node. To create a catalog for a given agent, the primary server compiles:
      * Data from the agent, such as facts or certificates
      * External data, such as values from functions or classification information from the PE console
      * Manifests, which can contain conditional logic to describe the desired state of resources for many nodes
    * The primary server resolves all of these elements and compiles a specific catalog for each individual agent. After the agent receives its catalog, it applies any changes needed to bring the agent to the state described in the catalog. Agents cache their most recent catalog. If they request a catalog and the primary server fails to compile one, they fall back to their cached catalog
    * Resources and classes: A resource describes some aspect of a system, such as a specific service or package. You can group resources together in classes, which generally configure larger chunks of functionality, such as all of the packages, configuration files, and services needed to run an application. The Puppet language is structured around resource declaration. When you declare a resource, you tell Puppet the desired state for that resource, so that Puppet can add it to the catalog and manage it. Every other part of the Puppet language exists to add flexibility and convenience to the way you declare resources. Just as you declare a single resource, you can declare a class to manage many resources at once. Whereas a resource declaration might manage the state of a single file or package, a class declaration can manage everything needed to configure an entire service or application, including packages, configuration files, service daemons, and maintenance tasks. In turn, small classes that manage a few resources can be combined into larger classes that describe entire custom system roles, such as "database server" or "web application worker." To add a class's resources to the catalog, either declare the class in a manifest or classify your nodes. Node classification allows you to assign a different set of classes to each node, based on the node's role in your infrastructure. You can classify nodes with node definitions or by using node-specific data from outside your manifests, such as that from an external node classifier or Hiera
    * Manifests: Resources are declared in manifests, Puppet language files that descrie how the resources must be configured. Manifests are a basic building block of Puppet and are kept in a specific file structure called a module. Manifests can contain conditional logic and declare resources for multiple agents. The primary server evaluates the contents of all the relevant manifests, resolves any logic, and compiles catalogs. Each catalog defines state for one specific node. Manifests:
      * Are text files with a .pp extension
      * Must use the UTF-8 encoding
      * Can use Unix (LF) or Windows (CRLF) line breaks
  * When compiling the catalog, the primary server always evaluates the main manifest first. This manifest, also known as the site manifest, defines global system configurations, such as [LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol) configurations, DNS servers, or other configurations that apply to every node. The main manifest can either be a single manifest, usually named `site.pp`, or a directory containing several manifests, which Puppet treats as a single file. The simplest Puppet deployment consists of a single main manifest file with a few resources
  * Manifest example: This short manifest manages NTP. It includes:
    * A case statement that sets the name of the NTP service, depending on which operating system is installed on the agent
    * A `package` resource that installs the NTP package on the agent
    * A `service` resource that enables and runs the NTP service. This resource also applies the NTP configuration settings from `ntp.conf` to the service
    * A `file` resource that creates the `ntp.conf` file on the agent in `/etc/ntp.conf`. This resource also requires that the `ntp` package is installed on the agent. The contents of the `ntp.conf` file will be taken from the specified source file, which is contained in the `ntp` module
  * Example .pp manifest:
```
case $operatingsystem {
    centos, redhat: { $service_name = 'ntpd' }
    debian, ubuntu: { $service_name = 'ntp' }
}

package { 'ntp':
    ensure => installed,
}

service { 'ntp':
    name        => $service_name,
    ensure      => running,
    enable      => true,
    subscribe   => File['ntp.conf'],
}

file { 'ntp.conf':
    path        => '/etc/ntp.conf',
    ensure      => file,
    require     => Package['ntp'],
    source      => "puppet:///modules/ntp/ntp.conf",
    # This source file would be located on the primary Puppet server at
    # /etc/puppetlabs/code/modules/ntp/files/ntp.conf
}
```

* 11:34AM: Now that I've taken a look at Puppet, I want to do some more research on [Ansible](https://docs.ansible.com/ansible/latest/index.html)
  * Introduction to Ansible: Ansible provides open-source automation that reduces complexity and runs everywhere. Using Ansible lets you automate virtually any task. Here are some common use cases for Ansible:
    * Eliminate repetition and simplify workflows
    * Manage and maintain system configuration
    * Continuously deploy complex software
    * Perform zero-downtime rolling updates
  * Ansible uses simple, human-readable scripts called playbooks to automate your tasks. You declare the desired state of a local or remote system in your playbook. Ansible ensures that the system remains in that state
  * As automation technology, Ansible is designed around the following principles:
    * Agent-less architecture: Low maintenance overhead by avoiding the installation of additional software across IT infrastructure
    * Simplicity: Automation playbooks use straightforward YAML syntax for code that reads like documentation. Ansible is also decentralized, using SSH with existing OS credentials to access to remote machines
    * Scalability and flexibility: Easily and quickly scale the systems you automate through a modular design that supports a large range of operating systems, cloud platforms, and network devices
    * Idempotence and predictability: When the system is in teh state your playbook describes, Ansible does not change anything, even if the playbook runs multiple times
  * Start automating with Ansible: Get started with Ansible by creating an automation project, building an inventory, and creating a "Hello World" playbook.
    1. Install Ansible `pip install ansible`
    1. Create a project folder on your filesystem `mkdir ansible_quickstart && cd ansible_quickstart
  * Using a single directory structure makes it easier to add to source control as well as to reuse and share automation content
  * Building an inventory: Inventories organize managed nodes in centralized files that provide Ansible with system information and network locations. Using an inventory file, Ansible can manage a large number of hosts with a single command. To complete the following steps, you'll need the IP address or fully qualified domain name (FQDN) of at least one host system. For demonstration purposes, the host could be running locally in a container or a virtual machine. You must also ensure that your public SSH key is added to the `authorized_keys` file on each host
  * Continue getting started with Ansible and build an inventory as follows:
    1. Create a file named `inventory.ini` in the previously created `ansible_quickstart`
    2. Add a new `[myhosts]` group to the `inventory.ini` file and specify the IP address or fully qualified domain name of each host system
```
[myhosts]
192.0.2.50
192.0.2.51
192.0.2.52
```
    3. Verify your inventory `ansible-inventory -i inventory.ini --list`
    4. Ping the `myhosts` group in your inventory `ansible myhosts -m ping -i inventory.ini` Note: pass the `-u` option with the `ansible` command if the username is different on the control node and the managed node(s)
```
192.0.2.50 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
192.0.2.51 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
192.0.2.52 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
  * You can create inventories in either INI files or in YAML. In most cases, INI files are straightforward and easy to read for a small number of managed nodes. Creating an inventory in YAML format becomes a sensible option as the number of managed nodes increases
  * Tips for building inventories:
    * Ensure that group names are meaningful and unique. Group names are case sensitive
    * Avoid spaces, hyphens, and preceding numbers in group names (`floor_19` instead of `19th_floor`)
    * Group hosts in your inventory logically according to their What, Where, and When:
      * What: Group hosts according to the topology, e.g. db, web, leaf, spine
      * Where: Group hosts by geographic location, e.g. datacenter, region, floor, building
      * When: Group hosts by stage, e.g. development, test, staging, production
    * Create metagroups that organize multiple groups in your inventory with the following syntax:
```
metagroupname:
    chlidren:
```
*
  * The following inventory illustrates a basic structure for a data center. This example inventory contains a `network` metagroup that includes all network devices and a `datacenter` metagroup that includes the `network` group and all webservers
```
leafs:
    hosts:
        leaf01:
            ansible_host: 192.0.2.100
        leaf02:
            ansible_host: 192.0.2.110
        
spines:
    hosts:
        spine01:
            ansible_host: 192.0.2.120
        spine02:
            ansible_host: 192.0.2.130

network:
    children:
        leafs:
        spines:

webservers:
    hosts:
        webserver01:
            ansible_host: 192.0.2.140
        webserver02:
            ansible_host: 192.0.2.150

datacenter:
    children:
        network:
        webservers:
```
*
  * Creating a playbook: Playbooks are automation blueprints in YAML format that Ansible uses to deploy and configure managed nodes
    * Playbook: A list of plays that define the order in which Ansible performs operations, from top to bottom, to achieve an overall goal
    * Play: An ordered list of tasks that maps to managed nodes in an inventory
    * Task: A reference to a single module that defines the operations that Ansible performs
    * Module: A unit of code or binary that Ansible runs on managed nodes. Ansible modules are grouped in collections with a Fully Qualified Collection Name (FQCN) for each module
  * The following steps will create a playbook that pings hosts and prints a "Hello World" message:
    1. Create a file named `playbook.yaml` in your `ansible_quickstart` directory with the following content:
```
name: My first play
hosts: myhosts
tasks:
    name: Ping my hosts
    ansible.builtin.ping:

    name: Print message
    ansible.builtin.debug:
        msg: Hello world
```
    2. Run your playbook `ansible-playbook -i inventory.ini playbook.yaml

* 2:21PM: Finished going over Ansible and Puppet. Looked through some research computing jobs on GlassDoor and found the following hiring requirements:
  * Linux Systems Ops Engineer:
    * Linux HPC or research computing environment experience
    * Experience in a CI/CD driven, peer-reviewed, systems change management environment
    * On-Prem Linux systems configuration management such as Puppet or Ansible
    * Systems scripting and/or programming (Bash, Python, Ruby, etc.)
    * Networked file and/or object storage administration (NFS, parallel file systems, Ceph, etc.)
    * Managing on-prem virtualization platforms (with a particular focus on OpenStack and VMWare)
    * Designing and leading small to midsized projects and working groups
  * DevSecOps Engineer:
    * Linux HPC or research computing environment(s)
    * Experience deploying SIEM tools in a Linux environment (Wazuh, CIS-CAT, Splunk), and their application to compliance benchmarks, file integrity monitoring, etc.
    * Familiarity with sysems configuration management environments (Puppet, Salt, Ansible, etc.)
    * Experience implementing security and policy controls while balancing systems usability and performance
    * Experience with software integrity validation tools using SBOMs or similar technologies
    * Experience with implementation of HIPAA, HITRUST, FISMA, or NIST security policies and related systems configurations

* 3PM: Security Analyst Staff Zoom Meeting
  * AbuseIPDB can be used to look up suspicious IP addresses
  * [UDP Scanner](https://threatpicture.com/terms/udp-scan/) 
  * 