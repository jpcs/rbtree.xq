xquery version "3.0";

(:
 : Copyright (c) 2010-2011 John Snelson
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 :     http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)

import module namespace map = "http://snelson.org.uk/functions/map" at "../map.xq";

let $rbmap := fold-left(map:put#2, map:create(), (
  map:entry("a", "aardvark"),
  map:entry("z", "zebra"),
  map:entry("e", ("elephant", "eagle")),
  map:entry("o", "osterich"),
  map:entry("t", "terrapin"),
  map:entry("a", "antelope")
))
let $map := map:get($rbmap, ?)
return (
  $map("a"),
  $map("e"),
  map:contains($rbmap, "k"),

  map:fold(
    function($a, $k, $v) {
      $a, concat("key: ", $k, ", value: (",
        string-join($v, ", "), ")")
    }, (), $rbmap)
)
