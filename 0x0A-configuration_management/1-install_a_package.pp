# Installs flask

class { 'python':
pip3 => true,
}

python::pip { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}
