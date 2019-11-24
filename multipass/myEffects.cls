VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "myEffects"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'---------------------------------------------------------------------------------------
' Module    : myEffects
' Author    : Roberto
' Date      : 05/02/2010
' Purpose   :
'---------------------------------------------------------------------------------------

'Author :Roberto Mior
'     reexre@gmail.com
'
'If you use source code or part of it please cite the author
'You can use this code however you like providing the above credits remain intact
'
'
'
'
'--------------------------------------------------------------------------------
Option Explicit


Enum IntensityMode
    Gaussian
    NotGaussian
End Enum


Private Type tHSP
    H             As Single
    S         As Single
    P         As Single
End Type

Private Type tVector
    X             As Single
    y         As Single
    L         As Single

End Type

Private Type Bitmap
    bmType        As Long
    bmWidth   As Long
    bmHeight  As Long
    bmWidthBytes As Long
    bmPlanes  As Integer
    bmBitsPixel As Integer
    bmBits    As Long
End Type

Private Declare Function GetObject Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, ByRef lpObject As Any) As Long
Private Declare Function GetBitmapBits Lib "gdi32" (ByVal hBitmap As Long, ByVal dwCount As Long, ByRef lpBits As Any) As Long
Private Declare Function SetBitmapBits Lib "gdi32" (ByVal hBitmap As Long, ByVal dwCount As Long, ByRef lpBits As Any) As Long

Private Sbyte() As Byte
Private Sbyte2() As Byte

Private BlurByte() As Byte

Private SepaByte() As Byte

'Private PGMByte() As Byte
'Private PGM_C_Byte() As Byte

Private BILAByte() As Byte
Private ContByte() As Byte
Private ContByte2() As Byte
Private COMPUTEsingle() As Single
Private BILASingle() As Single


Private HSP() As tHSP
Private Vec() As tVector

Private hBmp  As Bitmap

Private pW    As Integer
Private PH    As Integer
Private PB    As Integer


Private Fast_ExpIntensity() As Single
'Private Fast_IntensityDomain() As Single


Private Fast_ExpSpatial() As Single
Private Fast_SpatialDomain() As Single

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (dest As Any, _
                                                                     source As Any, ByVal bytes As Long)

Public Event PercDONE(PercValue As Single, CurrIteration As Long)


Private Function Fast_IntensityDomain(AbsDeltaIntensity As Single) As Single    '

    Fast_IntensityDomain = Fast_ExpIntensity(AbsDeltaIntensity)


End Function


Public Sub zInit_IntensityDomain(ByVal SigmaI, ByVal Mode)

Dim V         As Single
Dim V2        As Single
Dim lV        As Long
Dim lV2       As Long

Dim Cos0      As Boolean

    If SigmaI = 0 Then SigmaI = 0.00001


    Select Case Mode
        Case 0
            SigmaI = 2 * SigmaI * SigmaI
        Case 1
            SigmaI = 2 * SigmaI
        Case 2
            SigmaI = SigmaI
        Case 3
            SigmaI = 3 * SigmaI
        Case 4
            SigmaI = Atn(1) * 2 * SigmaI
    End Select

    'Stop
    ReDim Fast_ExpIntensity(255000)

    Cos0 = False
    For V = 0 To 255000
        V2 = (V / 255000)
        Select Case Mode
            Case 0   'Gaussian
                V2 = V2 * V2
                Fast_ExpIntensity(V) = Exp(-(V2 / SigmaI))
            Case 1  'Gaussian2
                Fast_ExpIntensity(V) = (Exp(-(V2 ^ 3 / SigmaI ^ 3)))
            Case 2  'NotGaussian
                Fast_ExpIntensity(V) = Exp(-(V2 / SigmaI))
            Case 3
                Fast_ExpIntensity(V) = 1 - V2 / SigmaI
                If Fast_ExpIntensity(V) < 0 Then Fast_ExpIntensity(V) = 0

            Case 4

                If Not (Cos0) Then
                    Fast_ExpIntensity(V) = Cos(Atn(1) * V2 / SigmaI)
                    If Fast_ExpIntensity(V) < 0 Then Fast_ExpIntensity(V) = 0: Cos0 = True

                Else
                    Fast_ExpIntensity(V) = 0
                End If

        End Select


    Next
    'Stop

    'ReDim Fast_IntensityDomain(0 To 2550, 0 To 2550)
    'For lV = 0 To 2550
    '    For lV2 = 0 To 2550
    '        Fast_IntensityDomain(lV, lV2) = Fast_ExpIntensity(Abs(lV - lV2)) * 100
    '    Next
    'Next

End Sub
Public Sub zInit_SpatialDomain(ByVal SigmaS)
Dim V         As Single
Dim V2        As Single
Dim X         As Long
Dim y         As Long
Dim D         As Long

    If SigmaS = 0 Then Exit Sub
    SigmaS = SigmaS * 2

    ReDim Fast_ExpSpatial(30 * 30 * 2)
    For V = 0 To 30 * 30 * 2
        V2 = V
        Fast_ExpSpatial(V) = Exp(-(V2 / (SigmaS)))
    Next


    ReDim Fast_SpatialDomain(-30 To 30, -30 To 30)
    For X = -30 To 30
        For y = -30 To 30
            D = X * X + y * y
            Fast_SpatialDomain(X, y) = Fast_ExpSpatial(D)
        Next
    Next



End Sub


Public Sub zSet_Source(pboxImageHandle As Long)
'Public Sub GetBits(pBoxPicHand As Long)
Dim iRet      As Long
    'Get the bitmap header
    iRet = GetObject(pboxImageHandle, Len(hBmp), hBmp)
    '   iRet = GetObject(pBoxPicHand, Len(hBmp), hBmp)

    'Resize to hold image data
    ReDim Sbyte(0 To (hBmp.bmBitsPixel \ 8) - 1, 0 To hBmp.bmWidth - 1, 0 To hBmp.bmHeight - 1) As Byte
    'Get the image data and store into Sbyte array
    'iRet = GetBitmapBits(pBox.Picture.Handle, hBmp.bmWidthBytes * hBmp.bmHeight, Sbyte(0, 0, 0))
    iRet = GetBitmapBits(pboxImageHandle, hBmp.bmWidthBytes * hBmp.bmHeight, Sbyte(0, 0, 0))


    pW = hBmp.bmWidth - 1
    PH = hBmp.bmHeight - 1
    PB = (hBmp.bmBitsPixel \ 8) - 1



    'ReDim PGMByte(0 To PB, 0 To pW, 0 To PH)


End Sub



Private Sub Class_Terminate()
'Stop

    Erase Sbyte
    Erase Sbyte2
    Erase ContByte
    Erase BlurByte
    Erase SepaByte

    'Erase PGMByte
    'Erase PGM_C_Byte

End Sub






Public Function zLimitMin0(V) As Byte
    If V < 0 Then zLimitMin0 = 0 Else: zLimitMin0 = V
End Function
Public Function zLimitMax255(V As Single) As Byte
    If V > 255 Then zLimitMax255 = 255 Else: zLimitMax255 = CByte(V)
End Function

Public Sub zEFF_Contour_Apply()
Dim X         As Long
Dim y         As Long

    For X = 0 + 1 To pW - 1
        For y = 0 + 1 To PH - 1

            If ContByte(0, X, y) > 0 Then

                BILAByte(0, X, y) = zLimitMin0(BILAByte(0, X, y) \ 1 - ContByte(0, X, y) \ 1)
                BILAByte(1, X, y) = zLimitMin0(BILAByte(1, X, y) \ 1 - ContByte(0, X, y) \ 1)
                BILAByte(2, X, y) = zLimitMin0(BILAByte(2, X, y) \ 1 - ContByte(0, X, y) \ 1)

            End If

        Next
    Next

End Sub
Public Sub zEFF_BilateralFilter(N As Long, Sigma As Single, SigmaSpatial As Single, Iterations As Long, ByVal IntensityMode, RGBmode As Boolean, Optional Directional = False)
'Author :Roberto Mior
'     reexre@gmail.com
'
'If you use source code or part of it please cite the author
'You can use this code however you like providing the above credits remain intact
'
'
'
'
Dim I         As Long

Dim X         As Long
Dim y         As Long
Dim ProgX     As Long    'For Progress Bar
Dim ProgXstep As Long    'For Progress Bar

Dim xP        As Long
Dim yP        As Long
Dim XmN       As Long
Dim XpN       As Long
Dim YmN       As Long
Dim YpN       As Long

Dim dR        As Single
Dim dG        As Single
Dim dB        As Single
Dim TR        As Long
Dim TG        As Long
Dim TB        As Long

Dim RDiv      As Single
Dim GDiv      As Single
Dim BDiv      As Single

Dim SpatialD  As Single

Dim DX        As Single
Dim DY        As Single

Dim LL        As Single
Dim AA        As Single
Dim BB        As Single


    If RGBmode Then
        ReDim BILAByte(0 To PB, 0 To pW, 0 To PH)
        ReDim BILASingle(0 To PB, 0 To pW, 0 To PH)
        ReDim COMPUTEsingle(0 To PB, 0 To pW, 0 To PH)
        For X = 0 To pW
            For y = 0 To PH
                COMPUTEsingle(2, X, y) = CSng(Sbyte(2, X, y)) * 1000
                COMPUTEsingle(1, X, y) = CSng(Sbyte(1, X, y)) * 1000
                COMPUTEsingle(0, X, y) = CSng(Sbyte(0, X, y)) * 1000
            Next
        Next
    Else
        ReDim BILAByte(0 To PB, 0 To pW, 0 To PH)
        ReDim BILASingle(0 To PB, 0 To pW, 0 To PH)
        ReDim COMPUTEsingle(0 To PB, 0 To pW, 0 To PH)

        For X = 0 To pW
            For y = 0 To PH
                RGB_CieLAB Sbyte(2, X, y), Sbyte(1, X, y), Sbyte(0, X, y), LL, AA, BB
                COMPUTEsingle(2, X, y) = LL * 1000
                COMPUTEsingle(1, X, y) = AA * 1000
                COMPUTEsingle(0, X, y) = BB * 1000
                
                'for black border (LAB)
                BILASingle(2, X, y) = 0
                BILASingle(1, X, y) = 127500
                BILASingle(0, X, y) = 127500
                
                Next
        Next

    End If


    ProgXstep = Round(pW / (100 / Iterations))

    For I = 1 To Iterations

        ProgX = 0

        'If Directional Then ComputeSlopes

        For X = 0 + N To pW - N
            'For X = 0 To pW

            XmN = X - N
            XpN = X + N

            For y = 0 + N To PH - N
                'For Y = 0 To PH

                TR = 0
                TG = 0
                TB = 0
                RDiv = 0
                GDiv = 0
                BDiv = 0

                YmN = y - N
                YpN = y + N

                For xP = XmN To XpN
                    For yP = YmN To YpN


                        dR = Fast_ExpIntensity(Abs(COMPUTEsingle(2, xP, yP) - COMPUTEsingle(2, X, y)))
                        dG = Fast_ExpIntensity(Abs(COMPUTEsingle(1, xP, yP) - COMPUTEsingle(1, X, y)))
                        dB = Fast_ExpIntensity(Abs(COMPUTEsingle(0, xP, yP) - COMPUTEsingle(0, X, y)))

                        SpatialD = Fast_SpatialDomain((xP - X), (yP - y))


                        ' If Directional Then SpatialD = SpatialD * Vec(xP, yP).L
                        '  SpatialD = Fast_SpatialDomain((xP - X) * (N - Vec(xP, yP).X) / N, (yP - Y) * (N - Vec(xP, yP).Y) / N)

                        dR = dR * SpatialD
                        dG = dG * SpatialD
                        dB = dB * SpatialD

                        TR = TR + (COMPUTEsingle(2, xP, yP)) * dR
                        TG = TG + (COMPUTEsingle(1, xP, yP)) * dG
                        TB = TB + (COMPUTEsingle(0, xP, yP)) * dB

                        RDiv = RDiv + dR
                        GDiv = GDiv + dG
                        BDiv = BDiv + dB

                    Next yP
                Next xP

                TR = TR / RDiv
                TG = TG / GDiv
                TB = TB / BDiv

                TR = IIf(TR < 255000, TR, 255000)
                TG = IIf(TG < 255000, TG, 255000)
                TB = IIf(TB < 255000, TB, 255000)

                BILASingle(2, X, y) = TR
                BILASingle(1, X, y) = TG
                BILASingle(0, X, y) = TB

            Next y

            ' for the progress bar
            If X > ProgX Then
                RaiseEvent PercDONE((I - 1) / Iterations + (X / pW) / Iterations, I)
                ProgX = ProgX + ProgXstep
            End If

        Next X

        DoEvents

        CopyMemory ByVal VarPtr(COMPUTEsingle(0, 0, 0)), ByVal VarPtr(BILASingle(0, 0, 0)), (CLng(PB + 1) * CLng(pW + 1) * CLng(PH + 1)) * 4    'Single Lenght=4 Bytes

    Next I


    If RGBmode Then
        For X = 0 To pW
            For y = 0 To PH
                BILAByte(2, X, y) = COMPUTEsingle(2, X, y) / 1000
                BILAByte(1, X, y) = COMPUTEsingle(1, X, y) / 1000
                BILAByte(0, X, y) = COMPUTEsingle(0, X, y) / 1000
            Next
        Next
    Else

        For X = 0 To pW
            For y = 0 To PH
                CieLAB_RGB COMPUTEsingle(2, X, y) / 1000, COMPUTEsingle(1, X, y) / 1000, COMPUTEsingle(0, X, y) / 1000, LL, AA, BB
                BILAByte(2, X, y) = LL
                BILAByte(1, X, y) = AA
                BILAByte(0, X, y) = BB
            Next
        Next

    End If

    RaiseEvent PercDONE(1, Iterations)

End Sub

Public Sub zGet_Effect(pboxImageHandle As Long)
Dim iRet      As Long

    iRet = SetBitmapBits(pboxImageHandle, hBmp.bmWidthBytes * hBmp.bmHeight, BILAByte(0, 0, 0))

    Erase BILAByte
    Erase BILASingle
    Erase COMPUTEsingle
    

End Sub

Public Sub zGet_Contour(pboxImageHandle As Long)
'USELESS
Dim iRet      As Long
    iRet = SetBitmapBits(pboxImageHandle, hBmp.bmWidthBytes * hBmp.bmHeight, ContByte(0, 0, 0))

    Erase ContByte
End Sub




Sub zPreview_Intensity(ByRef Pic As PictureBox, ByVal cSigma As Single, ByVal Mode)

Dim X         As Single


Dim V         As Single
Dim ky        As Single


Dim x1        As Single
Dim y1        As Single
Dim X2        As Single
Dim y2        As Single
Dim KX        As Single


    zInit_IntensityDomain cSigma, Mode

    Pic.Cls


    ky = 255 / Pic.ScaleHeight

    KX = 32   '25

    For X = 0 To KX
        V = Fast_IntensityDomain(Abs(X * 1000)) * 255    '2.55

        x1 = ((Pic.ScaleWidth / KX) * X)    '* 0.1
        y1 = Pic.ScaleHeight - V / ky
        X2 = ((Pic.ScaleWidth / KX) * (X + 1))    '* 0.1
        y2 = Pic.ScaleHeight


        Pic.Line (x1, y1)-(X2, y2), RGB(V, 0, 0), BF
    Next


    Pic.Refresh

End Sub
Sub zPreview_Spatial(ByRef Pic As PictureBox, ByVal NN, ByVal cSigma As Single)
Dim X         As Long
Dim y         As Long
Dim C         As Integer
Dim X2
Dim y2
Dim K         As Single

    K = Pic.ScaleWidth / ((NN * 2) + 1)

    zInit_SpatialDomain cSigma
    For X = -NN To NN
        For y = -NN To NN
            C = Fast_SpatialDomain(X, y) * 255
            X2 = (NN + X) * K
            y2 = (NN + y) * K
            Pic.Line (X2, y2)-(X2 + K, y2 + K), RGB(C, 0, 0), BF


        Next
    Next

End Sub

Public Sub zEFF_MedianFilter(N As Long, Iterations As Long)

Dim I         As Long

Dim X         As Long
Dim y         As Long

Dim xP        As Long
Dim yP        As Long
Dim XmN       As Long
Dim XpN       As Long
Dim YmN       As Long
Dim YpN       As Long


Dim TR        As Long
Dim TG        As Long
Dim TB        As Long



Dim RR()      As Byte
Dim GG()      As Byte
Dim BB()      As Byte
Dim T         As Byte


Dim Area      As Long
Dim MidP      As Long

Dim C         As Long
Dim CC        As Long

    Area = (N * 2 + 1) ^ 2

    ReDim RR(Area)
    ReDim GG(Area)
    ReDim BB(Area)
    MidP = Area \ 2 + 1

    ReDim BILAByte(0 To PB, 0 To pW, 0 To PH)

    For I = 1 To Iterations

        For X = 0 + N To pW - N
            XmN = X - N
            XpN = X + N
            For y = 0 + N To PH - N

                TR = 0
                TG = 0
                TB = 0

                YmN = y - N
                YpN = y + N
                C = 0
                For xP = XmN To XpN
                    For yP = YmN To YpN

                        C = C + 1


                        RR(C) = Sbyte(2, xP, yP)
                        GG(C) = Sbyte(1, xP, yP)
                        BB(C) = Sbyte(0, xP, yP)

                        CC = C
                        While (CC > 0) And (RR(CC) < RR(CC - 1))
                            T = RR(CC)
                            RR(CC) = RR(CC - 1)
                            RR(CC - 1) = T
                            CC = CC - 1
                        Wend

                        CC = C
                        While (CC > 0) And (GG(CC) < GG(CC - 1))
                            T = GG(CC)
                            GG(CC) = GG(CC - 1)
                            GG(CC - 1) = T
                            CC = CC - 1
                        Wend

                        CC = C
                        While (CC > 0) And (BB(CC) < BB(CC - 1))
                            T = BB(CC)
                            BB(CC) = BB(CC - 1)
                            BB(CC - 1) = T
                            CC = CC - 1
                        Wend

                    Next
                Next


                'Debug.Print "------------------"
                '                For C = 0 To Area
                '                Debug.Print RR(C)
                '                Next
                '                Stop


                BILAByte(2, X, y) = RR(MidP)
                BILAByte(1, X, y) = GG(MidP)
                BILAByte(0, X, y) = BB(MidP)


            Next
            DoEvents
        Next


        'For B = 0 To PB
        'For X = 0 To pW
        'For Y = 0 To PH
        'Sbyte(B, X, Y) = BILAByte(B, X, Y)
        'Next
        'Next
        'Next
        CopyMemory ByVal VarPtr(Sbyte(0, 0, 0)), ByVal VarPtr(BILAByte(0, 0, 0)), CLng(PB + 1) * CLng(pW + 1) * CLng(PH + 1)

    Next

End Sub





Public Sub zEFF_Contour(Contour_0_100 As Single, LumHue01 As Single)
Dim X         As Long
Dim y         As Long

Dim ContAmount As Single
Dim PercLUM   As Single
Dim PercHUE   As Single

    PercHUE = LumHue01
    PercLUM = 1 - PercHUE

    'Contour_0_100 = 25
    ContAmount = 0.00004 * Contour_0_100


    ReDim ContByte(0 To PB, 0 To pW, 0 To PH)
    ReDim ContByte2(0 To PB, 0 To pW, 0 To PH)

    ReDim HSP(0 To pW, 0 To PH)
    ReDim Vec(0 To pW, 0 To PH)

    For X = 0 To pW
        For y = 0 To PH
            With HSP(X, y)
                RGBtoHSP BILAByte(2, X, y), BILAByte(1, X, y), BILAByte(0, X, y), .H, .S, .P
            End With
        Next
    Next


    For X = 1 To pW - 1
        For y = 1 To PH - 1

            With Vec(X, y)


                .y = -(-HSP(X - 1, y - 1).P - 2 * HSP(X - 1, y).P - HSP(X - 1, y + 1).P + HSP(X + 1, y - 1).P + 2 * HSP(X + 1, y).P + HSP(X + 1, y + 1).P)
                .X = (-HSP(X - 1, y - 1).P - 2 * HSP(X, y - 1).P - HSP(X + 1, y - 1).P + HSP(X - 1, y + 1).P + 2 * HSP(X, y + 1).P + HSP(X + 1, y + 1).P)

                .X = Abs(.X * PercLUM)
                .y = Abs(.y * PercLUM)

                If HSP(X, y).P < 200 Then
                    .y = .y + PercHUE * HUEDifference(-HSP(X - 1, y).H, HSP(X + 1, y).H) * 4
                    .X = .X + PercHUE * HUEDifference(-HSP(X, y - 1).H, HSP(X, y + 1).H) * 4
                End If

                .L = (.X * .X + .y * .y)
                .L = .L * ContAmount

                'frmMAIN.PIC2.PSet (X, Y), RGB(.L, .L, .L)
                ContByte(0, X, y) = zLimitMax255(.L)

                DoEvents

            End With

        Next
    Next


End Sub


Public Sub ComputeSlopes()
Dim X         As Long
Dim y         As Long

Dim ContAmount As Single
Dim PercLUM   As Single
Dim PercHUE   As Single



    ReDim HSP(0 To pW, 0 To PH)
    ReDim Vec(0 To pW, 0 To PH)

    For X = 0 To pW
        For y = 0 To PH
            With HSP(X, y)
                RGBtoHSP Sbyte(2, X, y), Sbyte(1, X, y), Sbyte(0, X, y), .H, .S, .P
            End With
        Next
    Next


    For X = 1 To pW - 1
        For y = 1 To PH - 1

            With Vec(X, y)
                .y = -(-HSP(X - 1, y - 1).P - 2 * HSP(X - 1, y).P - HSP(X - 1, y + 1).P + HSP(X + 1, y - 1).P + 2 * HSP(X + 1, y).P + HSP(X + 1, y + 1).P)
                .X = (-HSP(X - 1, y - 1).P - 2 * HSP(X, y - 1).P - HSP(X + 1, y - 1).P + HSP(X - 1, y + 1).P + 2 * HSP(X, y + 1).P + HSP(X + 1, y + 1).P)

                .X = Abs(.y) / 255    ' * Val(frmMAIN.tRad)
                .y = Abs(.X) / 255    ' * Val(frmMAIN.tRad)


                If .X > Val(frmMAIN.tRad) Then .X = Val(frmMAIN.tRad)
                If .y > Val(frmMAIN.tRad) Then .y = Val(frmMAIN.tRad)
                If .X > 1 Then .X = 1
                If .y > 1 Then .y = 1
                .X = 1 - .X
                .y = 1 - .y

                .L = (.X * .X + .y * .y)

                DoEvents
            End With
        Next
    Next

End Sub





'Author :Roberto Mior





