object frmFamHistory: TfrmFamHistory
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Family History '
  ClientHeight = 617
  ClientWidth = 1362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnuFamHist
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 17
  object splitVert: TSplitter
    Left = 179
    Top = 0
    Width = 1
    Height = 617
    ExplicitLeft = 231
  end
  object Splitter1: TSplitter
    Left = 180
    Top = 0
    Width = 6
    Height = 617
    ExplicitLeft = 173
  end
  object pnlMain: TPanel
    Left = 186
    Top = 0
    Width = 1176
    Height = 617
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Caption = 'pnlFHDlog'
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1098
    object capLstFamHist: TCaptionListBox
      AlignWithMargins = True
      Left = 3880
      Top = 4217
      Width = 1043
      Height = 475
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = lbOwnerDrawVariable
      AutoComplete = False
      Align = alCustom
      Color = clWhite
      ItemHeight = 13
      Items.Strings = (
        
          'Brother        Gus      Living            56-60           Lung C' +
          'ancer               41-45                                    Dec' +
          'lined any treatment      12/19/2014         1/23/2015      '
        
          'Father         Fred     Deceased                           Prost' +
          'ate Cancer          71-75                     91+         Passed' +
          ' away at home        12/22/2014         1/24/2015               ' +
          '     '
        
          'Mother        Fran     Living            66-70            Breast' +
          ' Cancer             36-50                                    Wor' +
          'ked in coal mines         12/24/2014       '
        
          'Sister         Betty     Living            51/55            Cerv' +
          'ical Cancer           46-50                                    C' +
          'ancer is in her family        01/07/2015       ')
      ParentShowHint = False
      ShowHint = True
      Sorted = True
      TabOrder = 0
      OnDblClick = capLstFamHistDblClick
      Caption = 'Active Problems List'
      ExplicitLeft = 3828
      ExplicitTop = 4165
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 1174
      Height = 121
      Align = alTop
      TabOrder = 2
      ExplicitWidth = 1096
      object Label2: TLabel
        Left = 5
        Top = 98
        Width = 158
        Height = 17
        Caption = 'Family Disease History List'
      end
    end
    object sgfhist: TStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 146
      Width = 1168
      Height = 467
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ColCount = 10
      DrawingStyle = gdsClassic
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      GridLineWidth = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 3
      OnDblClick = sgfhistDblClick
      ExplicitWidth = 1090
    end
    object hc: THeaderControl
      Left = 1
      Top = 122
      Width = 1174
      Height = 21
      Hint = 'Age Diagnosed'
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Sections = <
        item
          ImageIndex = -1
          MaxWidth = 165
          MinWidth = 165
          Text = 'Relationship'
          Width = 165
        end
        item
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 60
          Text = 'Name'
          Width = 60
        end
        item
          AllowClick = False
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 80
          Text = 'Vital Status'
          Width = 80
        end
        item
          Alignment = taCenter
          ImageIndex = -1
          Text = 'Current Age'
          Width = 95
        end
        item
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 185
          Text = 'History of'
          Width = 185
        end
        item
          Alignment = taCenter
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 150
          Text = 'Age Diagnosed'
          Width = 100
        end
        item
          Alignment = taCenter
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 95
          Text = 'Age Deceased'
          Width = 95
        end
        item
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 190
          Text = 'Comments'
          Width = 190
        end
        item
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 85
          Text = ' Entered by'
          Width = 85
        end
        item
          Alignment = taCenter
          FixedWidth = True
          ImageIndex = -1
          MaxWidth = 110
          Text = 'Date Modified'
          Width = 110
        end>
      ParentFont = False
      ExplicitWidth = 1096
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 179
    Height = 617
    Align = alLeft
    TabOrder = 1
    TabStop = True
    DesignSize = (
      179
      617)
    object pnlButtons: TPanel
      Left = 2
      Top = 408
      Width = 176
      Height = 241
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 0
      object vsplit: TSplitter
        Left = 1
        Top = 1
        Width = 174
        Height = 8
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 6
      end
      object btnAddNewHistoryRecord: TORAlignButton
        Tag = 100
        Left = 1
        Top = 9
        Width = 174
        Height = 30
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alTop
        Caption = 'New Family History'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnAddNewHistoryRecordClick
      end
    end
    object Panel1: TPanel
      Left = 5
      Top = 26
      Width = 169
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 1
    end
    object pnlTop: TPanel
      Left = 7
      Top = 70
      Width = 172
      Height = 307
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 170
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = 'Disease Group List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 105
      end
      object lstView: TORListBox
        Left = 1
        Top = 17
        Width = 170
        Height = 289
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Style = lbOwnerDrawFixed
        Align = alClient
        Columns = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = lstViewClick
        Caption = ''
        ItemTipColor = clWindow
        LongList = False
        Pieces = '1'
        CheckBoxes = True
        FlatCheckBoxes = False
      end
    end
  end
  object mnuFamHist: TMainMenu
    Left = 707
    Top = 409
    object mnuView: TMenuItem
      Caption = '&View'
      GroupIndex = 3
      object mnuViewChart: TMenuItem
        Caption = 'Chart &Tab'
        object mnuChartCover: TMenuItem
          Tag = 1
          Caption = 'Cover &Sheet'
          ShortCut = 16467
        end
        object mnuChartProbs: TMenuItem
          Tag = 2
          Caption = '&Problem List'
          ShortCut = 16464
        end
        object mnuChartMeds: TMenuItem
          Tag = 3
          Caption = '&Medications'
          ShortCut = 16461
        end
        object mnuChartOrders: TMenuItem
          Tag = 4
          Caption = '&Orders'
          ShortCut = 16463
        end
        object mnuChartNotes: TMenuItem
          Tag = 6
          Caption = 'Progress &Notes'
          ShortCut = 16462
        end
        object mnuChartCslts: TMenuItem
          Tag = 7
          Caption = 'Consul&ts'
          ShortCut = 16468
        end
        object mnuChartSurgery: TMenuItem
          Tag = 11
          Caption = 'S&urgery'
          ShortCut = 16469
        end
        object mnuChartDCSumm: TMenuItem
          Tag = 8
          Caption = '&Discharge Summaries'
          ShortCut = 16452
        end
        object mnuChartLabs: TMenuItem
          Tag = 9
          Caption = '&Laboratory'
          ShortCut = 16460
        end
        object mnuChartReports: TMenuItem
          Tag = 10
          Caption = '&Reports'
          ShortCut = 16466
        end
      end
      object mnuViewInformation: TMenuItem
        Caption = 'Information'
        object mnuViewDemo: TMenuItem
          Tag = 1
          Caption = 'De&mographics...'
        end
        object mnuViewVisits: TMenuItem
          Tag = 2
          Caption = 'Visits/Pr&ovider...'
        end
        object mnuViewPrimaryCare: TMenuItem
          Tag = 3
          Caption = 'Primary &Care...'
        end
        object mnuViewMyHealtheVet: TMenuItem
          Tag = 4
          Caption = 'MyHealthe&Vet...'
        end
        object mnuInsurance: TMenuItem
          Tag = 5
          Caption = '&Insurance...'
        end
        object mnuViewFlags: TMenuItem
          Tag = 6
          Caption = '&Flags...'
        end
        object mnuViewRemoteData: TMenuItem
          Tag = 7
          Caption = 'Remote &Data...'
        end
        object mnuViewReminders: TMenuItem
          Tag = 8
          Caption = '&Reminders...'
          Enabled = False
        end
        object mnuViewPostings: TMenuItem
          Tag = 9
          Caption = '&Postings...'
        end
      end
      object Z1: TMenuItem
        Caption = '-'
      end
      object mnuViewActive: TMenuItem
        Tag = 700
        Caption = '&Active Problems'
      end
      object mnuViewInactive: TMenuItem
        Tag = 800
        Caption = '&Inactive Problems'
      end
      object mnuViewBoth: TMenuItem
        Tag = 900
        Caption = '&Both Active/Inactive Problems'
      end
      object mnuViewRemoved: TMenuItem
        Tag = 950
        Caption = '&Removed Problems'
      end
      object mnuViewFilters: TMenuItem
        Tag = 975
        Caption = 'Fi&lters...'
      end
      object mnuViewComments: TMenuItem
        Caption = 'Show &Comments'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnuViewSave: TMenuItem
        Caption = 'Sa&ve as Default View'
      end
      object mnuViewRestoreDefault: TMenuItem
        Caption = 'Return to De&fault View'
      end
    end
    object mnuAct: TMenuItem
      Caption = '&Action'
      GroupIndex = 4
      object mnuActNew: TMenuItem
        Tag = 100
        Caption = '&New Problem...'
      end
      object Z3: TMenuItem
        Caption = '-'
      end
      object mnuActChange: TMenuItem
        Tag = 400
        Caption = '&Change...'
        Enabled = False
      end
      object mnuActInactivate: TMenuItem
        Tag = 200
        Caption = '&Inactivate'
        Enabled = False
      end
      object mnuActVerify: TMenuItem
        Tag = 250
        Caption = '&Verify...'
        Enabled = False
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuActAnnotate: TMenuItem
        Tag = 600
        Caption = '&Annotate...'
        Enabled = False
      end
      object Z4: TMenuItem
        Caption = '-'
        Visible = False
      end
      object mnuActRemove: TMenuItem
        Tag = 500
        Caption = '&Remove'
        Enabled = False
      end
      object mnuActRestore: TMenuItem
        Tag = 550
        Caption = 'Re&store'
        Enabled = False
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mnuActDetails: TMenuItem
        Tag = 300
        Caption = 'View &Details'
        Enabled = False
      end
    end
  end
end
