Attribute VB_Name = "modEasyRGB"
Option Explicit


Private Const K1d3 As Single = 0.333333333333333  '1/3
Private Const K16d116 As Single = 0.137931034482759   '16/116
Private Const K1d2p4 As Single = 0.416666666666667    '1/2.4


Private Const LkMUL = 2.55
Private Const ABkMUL = 1.0625  '255/240



Public Declare Function GetPixel Lib "gdi32" (ByVal Hdc As Long, ByVal X As Long, ByVal y As Long) As Long
Public Declare Function SetPixel Lib "gdi32" (ByVal Hdc As Long, ByVal X As Long, ByVal y As Long, ByVal crColor As Long) As Long

Public Function CieLAB_RGB(ByVal cL, ByVal cA, ByVal cB, _
                           ByRef R As Single, ByRef G As Single, ByRef B As Single) As Boolean

Dim X         As Single
Dim y         As Single
Dim Z         As Single
Dim X3        As Single
Dim Y3        As Single
Dim Z3        As Single


    cL = cL / LkMUL
    cA = cA / ABkMUL
    cB = cB / ABkMUL

    cA = cA - 120
    cB = cB - 120


    CieLAB_RGB = True

    y = (cL + 16) / 116
    X = cA / 500 + y
    Z = y - cB / 200

    X3 = X * X * X
    Y3 = y * y * y
    Z3 = Z * Z * Z


    If (X3 > 0.008856) Then X = X3 Else: X = (X - K16d116) / 7.787
    If (Y3 > 0.008856) Then y = Y3 Else: y = (y - K16d116) / 7.787
    If (Z3 > 0.008856) Then Z = Z3 Else: Z = (Z - K16d116) / 7.787

    X = X * 0.95047        'Observer= 2°, Illuminant= D65
    'Y = Y * 1
    Z = Z * 1.08883


    R = (X * 3.2406 + y * -1.5372 + Z * -0.4986)
    G = (X * -0.9689 + y * 1.8758 + Z * 0.0415)
    B = (X * 0.0557 + y * -0.204 + Z * 1.057)

    If (R > 0.0031308) Then R = (1.055 * (R ^ K1d2p4) - 0.055) Else: R = 12.92 * R
    If (G > 0.0031308) Then G = (1.055 * (G ^ K1d2p4) - 0.055) Else: G = 12.92 * G
    If (B > 0.0031308) Then B = (1.055 * (B ^ K1d2p4) - 0.055) Else: B = 12.92 * B

    R = R * 255
    G = G * 255
    B = B * 255

    If R < 0 Then R = 0: CieLAB_RGB = False
    If G < 0 Then G = 0: CieLAB_RGB = False
    If B < 0 Then B = 0: CieLAB_RGB = False
    If R > 255 Then R = 255: CieLAB_RGB = False
    If G > 255 Then G = 255: CieLAB_RGB = False
    If B > 255 Then B = 255: CieLAB_RGB = False

End Function

Public Function RGB_CieLAB(ByVal R, ByVal G, ByVal B, _
                           ByRef cL As Single, ByRef cA As Single, ByRef cB As Single)

Dim X         As Single
Dim y         As Single
Dim Z         As Single

    R = (R / 255)
    G = (G / 255)
    B = (B / 255)

    If (R > 0.04045) Then R = ((R + 0.055) / 1.055) ^ 2.4 Else: R = R / 12.92
    If (G > 0.04045) Then G = ((G + 0.055) / 1.055) ^ 2.4 Else: G = G / 12.92
    If (B > 0.04045) Then B = ((B + 0.055) / 1.055) ^ 2.4 Else: B = B / 12.92

    'Observer. = 2°, Illuminant = D65
    X = R * 0.4124 + G * 0.3576 + B * 0.1805
    y = R * 0.2126 + G * 0.7152 + B * 0.0722
    Z = R * 0.0193 + G * 0.1192 + B * 0.9505

    X = X / 0.95047        'Observer= 2°, Illuminant= D65
    'Y = Y / 1
    Z = Z / 1.08883

    If (X > 0.008856) Then X = X ^ K1d3 Else: X = (7.787 * X) + (K16d116)
    If (y > 0.008856) Then y = y ^ K1d3 Else: y = (7.787 * y) + (K16d116)
    If (Z > 0.008856) Then Z = Z ^ K1d3 Else: Z = (7.787 * Z) + (K16d116)

    cL = 116 * y - 16
    cA = 500 * (X - y)
    cB = 200 * (y - Z)

    cA = cA + 120
    cB = cB + 120

    cL = cL * LkMUL
    cA = cA * ABkMUL
    cB = cB * ABkMUL


End Function
