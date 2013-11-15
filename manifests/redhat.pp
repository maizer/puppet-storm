class storm::redhat
{

	package { ['unzip', 'uuid']:
	    ensure  => installed,
    }
	
    package { 'zeromq':
    	provider	=> rpm,
        source		=> 'https://dl.dropbox.com/u/25821613/storm/zeromq-2.1.7-1.el6.x86_64.rpm',
        ensure      => '2.1.7-1.el6',
        require     => Package['uuid']
    }

    package { 'zeromq-devel':
    	provider	=> rpm,
        source		=> 'https://dl.dropbox.com/u/25821613/storm/zeromq-devel-2.1.7-1.el6.x86_64.rpm',
        ensure      => '2.1.7-1.el6',
        require		=> [Package['zeromq']]
    }

    package { 'jzmq':
    	ensure		=> '2.1.0-1.el6',
    	provider	=> rpm,
    	source		=> 'https://dl.dropbox.com/u/25821613/storm/jzmq-2.1.0-1.el6.x86_64.rpm',
    	require		=> [Package['zeromq']]
    }

    package { 'jzmq-devel':
    	ensure		=> '2.1.0-1.el6',
    	provider	=> rpm,
    	source		=> 'https://dl.dropbox.com/u/25821613/storm/jzmq-devel-2.1.0-1.el6.x86_64.rpm',
        require		=> [Package['jzmq']]
    }


    file{ "/app/home":
	ensure  => "directory"
    }
    

    group{ "storm":
		gid => 53001
    }   

    user { "storm":
	  home    => "/app/home/storm",
	  shell   => "/bin/bash",
	  uid     => 53001,
	  gid => 53001,
	  managehome => 'true',
	  require => Group[storm]
	 } 
    file{ "/app/home/storm":
	ensure => "directory",
	owner => "storm",
	group => "storm",
	mode => 700
    }


    exec { "zookeeper" : 
	command => "/usr/bin/wget https://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/cloudera-cdh4.repo",
	path =>  "/etc/yum.repos.d/cloudera-cdh4.repo",
	creates => "/etc/yum.repos.d/cloudera-cdh4.repo"
    }

}

include storm::redhat
