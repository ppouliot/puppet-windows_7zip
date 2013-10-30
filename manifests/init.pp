# === Class: windows_7zip
#
# This module installs 7-zip on Windows systems. It also adds an entry to the
# PATH environment variable.
#
# === Parameters
#
# [*url*]
#   HTTP url where the installer is available. It defaults to main site.
# [*package*]
#   Package name in the system.
# [*file_path*]
#   This parameter is used to specify a local path for the installer. If it is
#   set, the remote download from $url is not performed. It defaults to false.
#
# === Examples
#
# class { 'windows_7zip': }
#
# class { 'windows_7zip':
#   $url     => 'http://192.168.1.1/files/7zip.exe',
#   $package => '7-Zip 9.30 (x64 edition)',
# }
#
# === Authors
# 
#
class windows_7zip (
  $url       = $::windows_7zip::params::url,
  $package   = $::windows_7zip::params::package,
  $file_path = false,
) inherits windows_7zip::params {

  if $chocolatey {
    Package { provider => chocolatey }
  } else {
    Package {
      source          => $7zip_installer_path,
      install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG'],
      provider        => windows,
    }

    if $file_path {
      $7zip_installer_path = $file_path
    } else {
      $7zip_installer_path = "${::temp}\\${package}.exe"
      windows_common::remote_file{'7-zip':
        source      => $url,
        destination => $7zip_installer_path,
        before      => Package[$package],
      }
    }
  }
  package { $package:
    ensure          => installed,
  #  source          => $7zip_installer_path,
  #  install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG'],
  }

  $7zip_path = 'C:\Program Files\7-zip'
 
  windows_path { $7zip_path:
    ensure  => present,
    require => Package[$package],
  }
}
