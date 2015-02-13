#!/usr/bin/env bats

FIG_FILE="${BATS_TEST_DIRNAME}/php_5_3.yml"

container() {
  echo "$(fig -f ${FIG_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup() {
  fig -f "${FIG_FILE}" up -d

  sleep 10
}

teardown() {
  fig -f "${FIG_FILE}" kill
  fig -f "${FIG_FILE}" rm --force
}

@test "php" {
  docker exec "$(container)" /bin/su - root -mc "php -v"
}

@test "php: xdebug" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'Xdebug'"
}

@test "php: zend opcache" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'Zend OPcache'"
}

@test "php: advanced php debugger (apd)" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'Advanced PHP Debugger (APD)'"
}

@test "php: apcu" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'apcu'"
}

@test "php: memcached" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'memcached'"
}

@test "php: redis" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'redis'"
}

@test "php: igbinary" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'igbinary'"
}


@test "php: mssql" {
  docker exec "$(container)" /bin/su - root -mc "php -m | grep 'mssql'"
}

@test "drush" {
  docker exec "$(container)" /bin/su - root -mc "drush status"
}
