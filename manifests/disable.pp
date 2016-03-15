# === Class: windows_7zip::disable
#
# This class removes the installed components.

class windows_7zip::disable (
  $package   = $::windows_7zip::params::package,
) inherits windows_7zip::params {

  package { $package:
    ensure  => absent,
  }

  windows_path { $::7zip_path:
    ensure  => absent,
  }

  file { "${::temp}/${package}.exe":
    ensure  => absent,
  }

}
