import std/parsecsv
import std/strutils
from std/streams import newFileStream

proc progress(pos: int, max: int) =
    if pos mod 1000000 == 0:
        echo (pos / max) * 100, "%"

var s = newFileStream("data.csv", fmRead)

if s == nil:
  quit("cannot open the file")

var x: CsvParser
open(x, s, "data.csv")

# Discard the first row because it's the names of stuff
discard readRow(x)
# timestamp, user_hash, color, x_coord, y_coord, x2_coord (opt), y2_coord (opt)
# There are 160353104 rows
# Max x and y coordinates are (1999, 1999)
# Min x and y coordinates are (0, 0)


var pallete: array[32, int] = 
    [
        0xFFFFFF, 0xFFF8B8, 0xFFD635, 0xFFB470, 0xFFA800, 0xFF99AA, 0xFF4500, 0xFF3881, 0xE4ABFF, 0xDE107F, 0xD4D7D9, 0xBE0039, 0xB44AC0,
        0x9C6926, 0x94B3FF, 0x898D90, 0x811E9F, 0x7EED56, 0x6D482F, 0x6D001A, 0x6A5CFF, 0x51E9F4, 0x515252, 0x493AC1, 0x3690EA, 0x2450A4,
        0x00CCC0, 0x00CC78, 0x00A368, 0x009EAA, 0x00756F, 0x000000
    ]

var rows: int = 0
var max_row: int = 160353104
var up_to: int = int(max_row / 10)

while readRow(x):


    rows = rows + 1
    progress(rows, up_to)
    if rows > up_to:
        break



close(x)