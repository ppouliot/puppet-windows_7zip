# Class: windows_7zip::commands
#
#
# Parameters: none
#
# Actions:
#


class windows_7zip::commands {
  define extract_archive ($::archivefile){
    exec {"7z_extract_${name}":
      command => "7z.exe x ${::temp}\\${::archivefile}",
      path    => "${programw6432}\\7-Zip;${::path}",
      cwd     => $::temp,
      require => Package['7z930-x64'],
    }
  }
}
