#!/bin/sh
#\
exec tclsh "$0" "$@"

package require Thread

set ::clock_thread [thread::create {thread::wait} ]
set ::print_foo_thread [thread::create {thread::wait} ]

set ::start_time [clock seconds]
set ::now $::start_time

proc start {} {
  thread::send -async $::clock_thread {
    return [clock seconds]
  } ::now
  puts [clock format [expr $::now - $::start_time] -format {%T} -gmt true]

  after 1000 start
}

proc print_foo {} {
  puts "print foo"
  after 1000 print_foo
}

start
print_foo

vwait forever
