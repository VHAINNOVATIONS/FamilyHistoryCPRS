object fraFamHistory: TfraFamHistory
  Left = 0
  Top = 0
  Width = 320
  Height = 293
  TabOrder = 0
  object Label1: TLabel
    Left = 16
    Top = 26
    Width = 103
    Height = 16
    Caption = 'Diseases Selected'
  end
  object ListView1: TListView
    Left = 16
    Top = 48
    Width = 273
    Height = 150
    Checkboxes = True
    Columns = <>
    MultiSelect = True
    TabOrder = 0
    ViewStyle = vsList
  end
  object Button1: TButton
    Left = 214
    Top = 212
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 214
    Top = 243
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
end
