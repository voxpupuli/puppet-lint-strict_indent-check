# failing manifest
class 1 (
) {
  file { 'this':
    ensure  => 'present',
    require => [ 'abc',
                 'def', ],
  }
}
