Attribute VB_Name = "Module1"
Option Explicit

Sub ReferToCells()
Cells.Clear
'Cells(3, 2) = "ahoj"
'1. Range("C1", "E2").Value = "test"
'2 Range("C1:E2").Value = "test"
'note: 1 & 2 are two ways to select a range (multiple cells)
'3 Range("C5:C7, E5:E7").Value = "test"
Range("B9, F8").Value = "hey" '> 3 & 4 are to select separate ranges
'5 Range("C5:C7", "E5:E7").Value = "test"
'but 5 will select also D range in between > attention to ""

''in a nutshell, should i select one single connected range, use: "cell1:celln"
''should i select seperate ranges , use: "cellx:celln, celly:cellm"
''should i select seperate cells, use: "cell1, cell2, cell3, etc."

End Sub

Sub Properties_Methods()
'properties with value and text
Range("B6").Value = Range("B5").Value
Range("B7").Value = Range("B5").Text

'methods with delete
Range("B6").Delete xlShiftToLeft
'try again
'Range("B6").Value = 10200
'Range("B6").Delete xlShiftUp
Range("A9").EntireRow.Delete

'select a cell on a different tab (worksheets)
Worksheets("purpose").Select
Range("A1").Select
'note: select tab (worksheet) then cell (range) separately
'this won't work: Worksheets("purpose").Range("A1").Select

End Sub

Sub last_row()


Range("K6").Value = Range("A4").End(xlDown).Row
'method 1: to find the end from the top, _
but can't help when there's a blank row in between
Range("K8").Value = Range("A4").End(xlToRight).Column
Range("L6").Value = Range("A10000").End(xlUp).Row
'method 2: to assume the very end cell where no row exists, _
reaching up to the first found cell, _i.e. the last row on the table, _
this way can prevent the situation where the table has blank rows
Range("M6").Value = Range("A" & Rows.Count).End(xlUp).Row
'method 3: in case there are more rows on the table than 10000
Range("K7").Value = Range("A" & Rows.Count).End(xlUp).Row + 1
'find the next empty row so +1
Range("K9").Value = Range("A4").CurrentRegion.Address
Cells.Columns.AutoFit
Range("K9").Value = Range("A4").CurrentRegion.Rows.Count
'to find last used cell
Range("K11").Value = Cells.SpecialCells(xlCellTypeLastCell).Row
Range("K12").Value = ActiveSheet.UsedRange.Rows.Count

End Sub
