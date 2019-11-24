VERSION 5.00
Begin VB.Form frmMAIN 
   BackColor       =   &H00808080&
   Caption         =   "Multipass Bilateral Filter"
   ClientHeight    =   10095
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   15240
   LinkTopic       =   "Form1"
   ScaleHeight     =   673
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   1016
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox picMOVE 
      Appearance      =   0  'Flat
      BackColor       =   &H00008000&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   14520
      MousePointer    =   5  'Size
      ScaleHeight     =   15
      ScaleMode       =   0  'User
      ScaleWidth      =   36
      TabIndex        =   4
      Top             =   120
      Width           =   570
   End
   Begin VB.Frame MAINframe 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      ForeColor       =   &H80000008&
      Height          =   9375
      Left            =   10080
      TabIndex        =   3
      Top             =   120
      Width           =   5055
      Begin VB.CheckBox chPrintParams 
         BackColor       =   &H00808080&
         Caption         =   "Print Parameters"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00E0E0E0&
         Height          =   255
         Left            =   1320
         TabIndex        =   38
         ToolTipText     =   "Print Parameters to Output Picture(s)"
         Top             =   7560
         Value           =   1  'Checked
         Width           =   2175
      End
      Begin VB.CommandButton Command2 
         Caption         =   "START BILATERAL FILTERING"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   1320
         TabIndex        =   37
         Top             =   7920
         Width           =   2175
      End
      Begin VB.TextBox tFolder 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   240
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         TabIndex        =   34
         Text            =   "frmMAIN.frx":0000
         Top             =   360
         Width           =   4575
      End
      Begin VB.CheckBox chSelFold 
         Caption         =   "Select Folder (File)"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1320
         Style           =   1  'Graphical
         TabIndex        =   32
         Top             =   7080
         Width           =   2175
      End
      Begin VB.Frame Frame1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Parameters"
         ForeColor       =   &H80000008&
         Height          =   5895
         Left            =   240
         TabIndex        =   9
         Top             =   1080
         Width           =   3255
         Begin VB.CheckBox chDirectional 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Directional"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1440
            TabIndex        =   23
            Top             =   5040
            Visible         =   0   'False
            Width           =   1455
         End
         Begin VB.TextBox tMAXWH 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   360
            TabIndex        =   22
            Text            =   "520"
            ToolTipText     =   "Max Width/Height"
            Top             =   480
            Width           =   975
         End
         Begin VB.TextBox tSigma 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   360
            Locked          =   -1  'True
            TabIndex        =   21
            Text            =   "0"
            ToolTipText     =   "Sigma. Slower Value=Preserve more Edges"
            Top             =   1920
            Width           =   975
         End
         Begin VB.TextBox tIterations 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   360
            Locked          =   -1  'True
            TabIndex        =   20
            Text            =   "0"
            ToolTipText     =   "Number of Passes"
            Top             =   3720
            Width           =   975
         End
         Begin VB.TextBox tRad 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   360
            Locked          =   -1  'True
            TabIndex        =   19
            Text            =   "0"
            ToolTipText     =   "Radius(HalfLate) E.G.:  V=3 -> Sqaure 7*7, V=1 -> Square 3*3"
            Top             =   1320
            Width           =   975
         End
         Begin VB.CheckBox chALL 
            BackColor       =   &H00C0C0C0&
            Caption         =   "All Pictures in this Folder"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   360
            TabIndex        =   18
            Top             =   5400
            Width           =   1455
         End
         Begin VB.TextBox tCONT 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   360
            TabIndex        =   17
            Text            =   "0"
            ToolTipText     =   "Contour Sensitive Amount"
            Top             =   4440
            Width           =   975
         End
         Begin VB.TextBox tLumHue 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   360
            TabIndex        =   16
            Text            =   "0"
            ToolTipText     =   "0=Contour Based on Perceived Luminance. 1=Contour Based on HUE."
            Top             =   5040
            Width           =   975
         End
         Begin VB.HScrollBar scrIntensitySigma 
            Height          =   255
            Left            =   1440
            Max             =   1000
            TabIndex        =   15
            Top             =   1920
            Value           =   350
            Width           =   1695
         End
         Begin VB.HScrollBar scrRAD 
            Height          =   255
            Left            =   1440
            Max             =   30
            Min             =   1
            TabIndex        =   14
            Top             =   1320
            Value           =   3
            Width           =   1695
         End
         Begin VB.HScrollBar scrITER 
            Height          =   255
            Left            =   1440
            Max             =   25
            Min             =   1
            TabIndex        =   13
            Top             =   3720
            Value           =   4
            Width           =   1695
         End
         Begin VB.HScrollBar scrSpatial 
            Height          =   255
            Left            =   1440
            Max             =   10000
            TabIndex        =   12
            Top             =   3000
            Value           =   200
            Width           =   1695
         End
         Begin VB.TextBox tSigmaSpatial 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   360
            Locked          =   -1  'True
            TabIndex        =   11
            Text            =   "0"
            Top             =   3000
            Width           =   975
         End
         Begin VB.ComboBox cmbIntensityMode 
            Height          =   315
            Left            =   1440
            TabIndex        =   10
            Top             =   2280
            Width           =   1695
         End
         Begin VB.Frame frameColorMode 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            ForeColor       =   &H80000008&
            Height          =   615
            Left            =   1440
            TabIndex        =   43
            Top             =   360
            Width           =   1695
            Begin VB.OptionButton oLAB 
               BackColor       =   &H00E0E0E0&
               Caption         =   "LAB"
               Height          =   255
               Left            =   840
               TabIndex        =   45
               ToolTipText     =   "cieLAB Color Space"
               Top             =   240
               Width           =   735
            End
            Begin VB.OptionButton oRGB 
               BackColor       =   &H00E0E0E0&
               Caption         =   "RGB"
               Height          =   255
               Left            =   120
               TabIndex        =   44
               ToolTipText     =   "RGB Color Space"
               Top             =   240
               Value           =   -1  'True
               Width           =   735
            End
         End
         Begin VB.Label Label1 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            Caption         =   "Max Width-Height"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   31
            Top             =   240
            Width           =   1455
         End
         Begin VB.Label Label2 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            Caption         =   "INTENSITY Sigma 0-1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   360
            TabIndex        =   30
            Top             =   1680
            Width           =   2655
         End
         Begin VB.Label Label3 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            Caption         =   "Radius (HalfLate)"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   360
            TabIndex        =   29
            Top             =   1080
            Width           =   2655
         End
         Begin VB.Label lContour 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            Caption         =   "Contour Amount 0-100"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   360
            TabIndex        =   28
            Top             =   4200
            Width           =   2655
         End
         Begin VB.Label Label4 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            Caption         =   "Cont Lum-Hue (0-1)"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   240
            TabIndex        =   27
            Top             =   4800
            Width           =   2775
         End
         Begin VB.Label Label5 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            Caption         =   "SPATIAL Sigma"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   360
            TabIndex        =   26
            Top             =   2760
            Width           =   2655
         End
         Begin VB.Label Label7 
            Alignment       =   1  'Right Justify
            BackColor       =   &H00C0C0C0&
            Caption         =   "Inten.MODE:"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   120
            TabIndex        =   25
            Top             =   2355
            Width           =   1215
         End
         Begin VB.Label Iterations 
            Alignment       =   2  'Center
            BackColor       =   &H00C0C0C0&
            Caption         =   "Iterations"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   360
            TabIndex        =   24
            Top             =   3480
            Width           =   2655
         End
      End
      Begin VB.PictureBox SigmaPrev 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   1695
         Left            =   3600
         ScaleHeight     =   111
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   79
         TabIndex        =   8
         ToolTipText     =   "X = Delta Intensity from Central Point. (displaied range 0-32 of 255) .  Y = % Used (0-100)"
         Top             =   1920
         Width           =   1215
      End
      Begin VB.PictureBox PicSpatial 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   1215
         Left            =   3600
         ScaleHeight     =   79
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   79
         TabIndex        =   7
         ToolTipText     =   "Spatial Domain"
         Top             =   4080
         Width           =   1215
      End
      Begin VB.CheckBox chPreviewMode 
         Caption         =   "Preview Mode"
         Height          =   735
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   7920
         Width           =   855
      End
      Begin VB.CheckBox chMakeCompare 
         Caption         =   "Make Compare Picture"
         Height          =   735
         Left            =   3600
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   7920
         Value           =   1  'Checked
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.FileListBox File1 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2340
         Left            =   240
         TabIndex        =   33
         Top             =   3960
         Visible         =   0   'False
         Width           =   3255
      End
      Begin VB.DirListBox Dir1 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2490
         Left            =   240
         TabIndex        =   35
         Top             =   1440
         Visible         =   0   'False
         Width           =   3255
      End
      Begin VB.DriveListBox Drive1 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   240
         TabIndex        =   36
         Top             =   1110
         Visible         =   0   'False
         Width           =   3255
      End
      Begin VB.Label MainFrameLabel 
         BackColor       =   &H00C0C000&
         Caption         =   "      Panel"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   0
         TabIndex        =   42
         ToolTipText     =   "Click to Hide/show"
         Top             =   0
         Width           =   5055
      End
      Begin VB.Label LabProg 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "100%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   39
         Top             =   8760
         Width           =   1695
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "Intensity"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00E0E0E0&
         Height          =   255
         Left            =   3600
         TabIndex        =   41
         Top             =   1680
         Width           =   1215
      End
      Begin VB.Label Label6 
         BackStyle       =   0  'Transparent
         Caption         =   "Spatial"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00E0E0E0&
         Height          =   255
         Left            =   3600
         TabIndex        =   40
         Top             =   3720
         Width           =   1215
      End
      Begin VB.Shape ShapeBG 
         BorderWidth     =   2
         Height          =   255
         Left            =   240
         Top             =   8760
         Width           =   4575
      End
      Begin VB.Shape ShapeProg 
         BorderWidth     =   2
         FillColor       =   &H0000C000&
         FillStyle       =   0  'Solid
         Height          =   255
         Left            =   240
         Top             =   8760
         Width           =   4575
      End
   End
   Begin VB.PictureBox PIC2 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   4935
      Left            =   120
      ScaleHeight     =   329
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   449
      TabIndex        =   0
      Top             =   4320
      Visible         =   0   'False
      Width           =   6735
   End
   Begin VB.PictureBox PIC1 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      FillColor       =   &H0080FFFF&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   3795
      Left            =   120
      ScaleHeight     =   253
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   388
      TabIndex        =   1
      Top             =   120
      Width           =   5820
      Begin VB.Shape sP 
         BorderWidth     =   2
         Height          =   1095
         Left            =   480
         Top             =   480
         Visible         =   0   'False
         Width           =   1215
      End
   End
   Begin VB.PictureBox PicIN 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   4995
      Left            =   960
      ScaleHeight     =   333
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   500
      TabIndex        =   2
      Top             =   -4320
      Visible         =   0   'False
      Width           =   7500
   End
End
Attribute VB_Name = "frmMAIN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private WithEvents FX As myEffects
Attribute FX.VB_VarHelpID = -1


Private MaxWH As Integer


Private N     As Long
Private SigmaIntensity As Single
Private SigmaSpatial As Single
Private ITER  As Long
Private IntensityMode As Integer


Private pX1   As Integer
Private pY1   As Integer
Private pX2   As Integer
Private pY2   As Integer
Private Rect  As Boolean
Private PREVIEWmode As Boolean


Private Const JpgQuality As Byte = 97    ' 95



Private Sub chPreviewMode_Click()
    PREVIEWmode = IIf(chPreviewMode.Value = Checked, True, False)
    sP.Visible = PREVIEWmode
    chMakeCompare.Visible = PREVIEWmode
End Sub

Private Sub chSelFold_Click()

    If chSelFold.Value = Checked Then
        Drive1.Visible = True
        Dir1.Visible = True
        File1.Visible = True
        Frame1.Visible = False

    Else
        Drive1.Visible = False
        Dir1.Visible = False
        File1.Visible = False

        Frame1.Visible = True
    End If


End Sub

Private Sub cmbIntensityMode_Click()
    IntensityMode = cmbIntensityMode.ListIndex
    FX.zPreview_Intensity SigmaPrev, SigmaIntensity, IntensityMode

End Sub

Private Sub Command2_Click()

Dim S         As String
Dim S2        As String


Dim SPath     As String


    SaveSetting "LastSettings.txt"


    SPath = Dir1 & "\"

    If chALL.Value = Checked Then
        S = Dir(SPath & "*.jpg")
    Else
        S = File1
    End If

    If S = "" Then MsgBox "Select a Folder/File", vbCritical: Exit Sub

    PIC2.Cls
    PIC2.Width = sP.Width - 1
    PIC2.Height = sP.Height - 1
    PIC2.Refresh
    PIC2.Visible = PREVIEWmode
    PIC2.Top = PIC1.Top + sP.Top
    PIC2.Left = PIC1.Left + sP.Left



    Do
        Me.Caption = "Filering... " & S & " (Wait)"

        S2 = "R=" & tRad & "  I=" & tSigma & "  S=" & tSigmaSpatial & "  IT=" & tIterations & "  C=" & tCONT & "|" & tLumHue & "  iMode=" & IntensityMode & "  " & IIf(oRGB, "RGB", "CieLAB")

        PicIN.Cls
        PicIN.Picture = LoadPicture(SPath & S)
        PicIN.Refresh

        PIC1.Cls

        If PicIN.Width > PicIN.Height Then
            PIC1.Width = MaxWH
            PIC1.Height = PicIN.Height / PicIN.Width * PIC1.Width

        Else
            PIC1.Height = MaxWH
            PIC1.Width = PicIN.Width / PicIN.Height * PIC1.Height

        End If

        SetStretchBltMode PIC1.Hdc, vbPaletteModeNone
        StretchBlt PIC1.Hdc, 0, 0, PIC1.Width, PIC1.Height, PicIN.Hdc, 0, 0, PicIN.Width - 1, PicIN.Height - 1, vbSrcCopy
        PIC1.Refresh


        If PREVIEWmode Then
            If chMakeCompare.Value = Checked Then
                PicIN.Cls
                PicIN.Width = PIC2.Width * 2 - 1
                PicIN.Height = PIC2.Height
                PicIN.Refresh
                SetStretchBltMode PicIN.Hdc, vbPaletteModeNone
                StretchBlt PicIN.Hdc, 0, 0, PIC2.Width - 1, PIC2.Height - 1, PIC1.Hdc, sP.Left, sP.Top, PIC2.Width - 1, PIC2.Height - 1, vbSrcCopy
                PicIN.Refresh

            End If


            SetStretchBltMode PIC2.Hdc, vbPaletteModeNone
            StretchBlt PIC2.Hdc, 0, 0, PIC2.Width, PIC2.Height, PIC1.Hdc, sP.Left, sP.Top, PIC2.Width, PIC2.Height, vbSrcCopy
            PIC2.Refresh
            SaveJPG PIC2.Image, App.Path & "\OUT\EFForig" & S, JpgQuality
            FX.zSet_Source PIC2.Image.Handle
            FX.zEFF_BilateralFilter N, SigmaIntensity, SigmaSpatial, ITER, IntensityMode, oRGB    ' IIf(chDirectional.Value = Checked, True, False)
            FX.zEFF_Contour Val(tCONT), Val(tLumHue)
            FX.zEFF_Contour_Apply
            FX.zGet_Effect PIC2.Image.Handle
            SaveJPG PIC2.Image, App.Path & "\OUT\EFFprev" & S, JpgQuality
            If chMakeCompare.Value = Checked Then
                StretchBlt PicIN.Hdc, PIC2.Width - 1, 0, PIC2.Width - 1, PIC2.Height - 1, PIC2.Hdc, 0, 0, PIC2.Width - 1, PIC2.Height - 1, vbSrcCopy
                PicIN.Refresh
                If chPrintParams.Value = Checked Then
                    PrintTextToPic S2, PicIN
                End If
                SaveJPG PicIN.Image, App.Path & "\OUT\Compare_" & S, JpgQuality
            End If
        Else

            '**************************************************
            FX.zSet_Source PIC1.Image.Handle
            FX.zEFF_BilateralFilter N, SigmaIntensity, SigmaSpatial, ITER, IntensityMode, oRGB    'IIf(chDirectional.Value = Checked, True, False)
            FX.zEFF_Contour Val(tCONT), Val(tLumHue)
            FX.zEFF_Contour_Apply
            FX.zGet_Effect PIC1.Image.Handle

            If chPrintParams.Value = Checked Then
                PrintTextToPic S2, PIC1
            End If

            SaveJPG PIC1.Image, App.Path & "\OUT\" & S, JpgQuality
            '***********************************************************

        End If

        If (Not (PREVIEWmode)) And chALL.Value = Checked Then
            S = Dir
        Else
            S = ""
        End If

    Loop While S <> ""

    Me.Caption = "Filering Done."


End Sub

Private Sub Dir1_Change()
    tFolder = Dir1
    File1 = Dir1 & "\*.jpg"
End Sub



Private Sub Drive1_Change()
    Dir1.Path = Drive1

End Sub

Private Sub File1_Click()
    PicIN.Cls

    PicIN.Picture = LoadPicture(Dir1 & "\" & File1)
    PicIN.Refresh

    PIC1.Cls

    If PicIN.Width > PicIN.Height Then
        PIC1.Width = MaxWH
        PIC1.Height = PicIN.Height / PicIN.Width * PIC1.Width

    Else
        PIC1.Height = MaxWH
        PIC1.Width = PicIN.Width / PicIN.Height * PIC1.Height

    End If
    SetStretchBltMode PIC1.Hdc, vbPaletteModeNone
    StretchBlt PIC1.Hdc, 0, 0, PIC1.Width, PIC1.Height, PicIN.Hdc, 0, 0, PicIN.Width - 1, PicIN.Height - 1, vbSrcCopy
    PIC1.Refresh

End Sub

Private Sub Form_Load()
    Me.Caption = Me.Caption & " V" & App.Major & "." & App.Minor

    Set FX = New myEffects

    If Dir(App.Path & "\OUT", vbDirectory) = "" Then MkDir App.Path & "\OUT"



    tFolder = Dir1
    File1 = Dir1 & "\*.jpg"


    tMAXWH = 520
    MaxWH = 520


    FX.zInit_SpatialDomain 10

    scrRAD_Change
    scrIntensitySigma_Change
    scrSpatial_Change
    scrITER_Change


    cmbIntensityMode.AddItem "0 Gaussian"
    cmbIntensityMode.AddItem "1 Gaussian2"
    cmbIntensityMode.AddItem "2 InvProp"
    cmbIntensityMode.AddItem "3 Linear"
    cmbIntensityMode.AddItem "4 Cosine"

    cmbIntensityMode.ListIndex = 0

    LoadSetting "LastSettings.txt"


    FX.zInit_IntensityDomain SigmaIntensity, IntensityMode

    If App.LogMode = 0 Then MsgBox "Compile me!", vbInformation


End Sub

Private Sub Form_Unload(Cancel As Integer)
    SaveSetting "LastSettings.txt"
    End
End Sub


Private Sub FX_PercDONE(Value As Single, CI As Long)
    ShapeProg.Width = ShapeBG.Width * Value
    LabProg = Int(Value * 100) & "%  Iteration " & CI & ""
End Sub



Private Sub MainFrameLabel_Click()
    MAINframe.Height = IIf(MAINframe.Height > 18, 18, 625)


End Sub



Private Sub PIC1_MouseDown(Button As Integer, Shift As Integer, X As Single, y As Single)
    If PREVIEWmode Then
        PIC2.Visible = False
        If Rect = False Then
            pX1 = X
            pY1 = y
        End If
        Rect = Not Rect
    End If

End Sub

Private Sub PIC1_MouseMove(Button As Integer, Shift As Integer, X As Single, y As Single)


    If PREVIEWmode Then
        If Rect Then
            pX2 = X
            pY2 = y

            If pX2 < pX1 Then
                sP.Left = pX2
                sP.Width = pX1 - pX2
            Else
                sP.Left = pX1
                sP.Width = pX2 - pX1
            End If

            If pY2 < pY1 Then
                sP.Top = pY2
                sP.Height = pY1 - pY2
            Else
                sP.Top = pY1
                sP.Height = pY2 - pY1
            End If

        End If
    End If
End Sub


Private Sub picMOVE_MouseMove(Button As Integer, Shift As Integer, X As Single, y As Single)
    If Button = 1 Then
        picMOVE.Left = picMOVE.Left + X - picMOVE.Width \ 2
        picMOVE.Top = picMOVE.Top + y - picMOVE.Height \ 2
        MAINframe.Left = picMOVE.Left - MAINframe.Width + picMOVE.Width
        'MAINframe.Left = picMOVE.Left
        MAINframe.Top = picMOVE.Top    '+ picMOVE.Height \ 2
    End If

End Sub

Private Sub scrIntensitySigma_Change()
    tSigma = scrIntensitySigma / 1000

End Sub

Private Sub scrIntensitySigma_Scroll()
    tSigma = scrIntensitySigma / 1000
End Sub

Private Sub scrITER_Change()
    tIterations = scrITER

End Sub

Private Sub scrITER_Scroll()
    tIterations = scrITER
End Sub
Private Sub scrRAD_Change()
    tRad = scrRAD

End Sub

Private Sub scrRAD_Scroll()
    tRad = scrRAD
End Sub

Private Sub scrSpatial_Change()
    tSigmaSpatial = scrSpatial / 10

End Sub

Private Sub scrSpatial_Scroll()
    tSigmaSpatial = scrSpatial / 10

End Sub

Private Sub tIterations_Change()
    ITER = Val(tIterations)
End Sub

Private Sub tLumHue_Change()
    If Val(tLumHue) < 0 Then tLumHue = 0
    If Val(tLumHue) > 1 Then tLumHue = 1

End Sub

Private Sub tMAXWH_Change()
    MaxWH = Val(tMAXWH)
End Sub

Private Sub tRad_Change()
    N = Val(tRad)
    If N < 1 Then N = 1: tRad = N
    FX.zPreview_Spatial PicSpatial, N, SigmaSpatial

End Sub

Private Sub tSigma_Change()


    SigmaIntensity = Val(Replace(tSigma, ",", ".")) * 0.1

    FX.zPreview_Intensity SigmaPrev, SigmaIntensity, IntensityMode


End Sub

Private Sub tSigmaSpatial_Change()
    SigmaSpatial = Val(Replace(tSigmaSpatial, ",", "."))
    FX.zPreview_Spatial PicSpatial, N, SigmaSpatial

End Sub


Public Sub SaveSetting(f As String)
    Open App.Path & "\" & f For Output As 1
    Print #1, scrRAD
    Print #1, scrIntensitySigma
    Print #1, scrSpatial
    Print #1, scrITER
    Print #1, tCONT
    Print #1, tLumHue
    Print #1, cmbIntensityMode
    Print #1, IIf(oRGB, 1, 0)
    Close 1

End Sub
Public Sub LoadSetting(f As String)
Dim S         As String
Dim N         As Single

    Open App.Path & "\" & f For Input As 1
    Input #1, N: scrRAD.Value = N
    Input #1, N: scrIntensitySigma.Value = N
    Input #1, N: scrSpatial = N
    Input #1, N: scrITER.Value = N

    Input #1, S: tCONT = S
    Input #1, S: tLumHue = S
    Input #1, S
    cmbIntensityMode.ListIndex = Val(Left$(S, 1))
    Input #1, N
    If N = 1 Then
        oRGB = True
    Else
        oLAB = True
    End If
    
    Close 1

End Sub

Private Sub PrintTextToPic(txt As String, ByRef Pic As PictureBox)
    Pic.CurrentX = 6 + 1
    Pic.CurrentY = Pic.Height - 20 + 1
    Pic.ForeColor = vbWhite
    Pic.Print txt

    Pic.CurrentX = 6 - 1
    Pic.CurrentY = Pic.Height - 20 - 1
    Pic.ForeColor = vbBlack
    Pic.Print txt

    Pic.CurrentX = 6
    Pic.CurrentY = Pic.Height - 20
    Pic.ForeColor = vbGreen
    Pic.Print txt
End Sub

