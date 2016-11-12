#!/usr/bin/env ruby

require "byebug"
require "set"
require "pp" # pretty print


$debug = [0, 1, 0, 0]

def debug_log(index, str)
  $stderr.puts str if $debug[index] == 1
end

def cross(prefixes_arr, suffixes_arr)
  results = []
  prefixes_arr.each do |prefixes|
    suffixes_arr.each do |suffixes|
      debug_log 0, "prefixes / suffixes: #{prefixes} / #{suffixes}"
      subresults = []
      prefixes.split("").each do |prefix|
        suffixes.split("").each do |suffix|
          subresults << prefix + suffix
        end # /suffixes
      end # /prefixes
      results << subresults
    end # /suffixes_arr
  end # /prefixes_arr
  results
end


row_list = "abcdefghi" # ("a".."i").to_a #
col_list = "123456789" # ("1".."9").to_a #

squares = cross([row_list], [col_list]).flatten
debug_log 1, "squares: #{squares}"
# p squares

boxes = cross(["abc", "def", "ghi"], ["123", "456", "789"])
debug_log 1, "boxes: #{boxes}"

cols = cross([row_list], col_list.split(""))
debug_log 1, "cols: #{cols}"

rows = cross(row_list.split(""), [col_list])
debug_log 1, "rows: #{rows}"

units = rows + cols + boxes
debug_log 2, "units: #{units}"

# peers - shared with a square, not including square.
peers = {}
squares.each do |square|
  square_peers = []
  units.each do |unit|
    if unit.include? square
      square_peers += unit
    end
  end
  square_peers = square_peers.uniq.sort
  square_peers.delete square
  peers[square] = square_peers
end

debug_log 3, "c5 peers: #{peers["c5"]}"
