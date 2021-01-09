object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'FormMain'
  ClientHeight = 901
  ClientWidth = 1334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanInertia, igoParentPassthrough]
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1334
    Height = 901
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'iFood'
      object Memo1: TMemo
        Left = 241
        Top = 43
        Width = 1085
        Height = 818
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 200
        ExplicitTop = 0
        ExplicitWidth = 1126
        ExplicitHeight = 861
      end
      object SplitView1: TSplitView
        Left = 0
        Top = 43
        Width = 241
        Height = 818
        OpenedWidth = 200
        Placement = svpLeft
        TabOrder = 1
        ExplicitTop = 0
        ExplicitHeight = 861
        object btnGetToken: TSpeedButton
          Left = 0
          Top = 25
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'GetToken'
          OnClick = btnGetTokenClick
          ExplicitTop = 0
          ExplicitWidth = 200
        end
        object btnClear: TSpeedButton
          Left = 0
          Top = 793
          Width = 241
          Height = 25
          Align = alBottom
          Caption = 'Clear'
          OnClick = btnClearClick
          ExplicitTop = 592
          ExplicitWidth = 200
        end
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Authentication'
          ExplicitWidth = 124
        end
        object Label2: TLabel
          Left = 0
          Top = 175
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Merchant v2'
          ExplicitWidth = 105
        end
        object btnMerchants: TSpeedButton
          Left = 0
          Top = 75
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Merchants [GET]'
          OnClick = btnMerchantsClick
          ExplicitTop = 69
          ExplicitWidth = 200
        end
        object btnPostUnavailabilities: TSpeedButton
          Left = 0
          Top = 150
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Unavailabilities [POST]'
          OnClick = btnMerchantsClick
          ExplicitLeft = -16
          ExplicitTop = 106
          ExplicitWidth = 200
        end
        object btnDeleteUnavailabilities: TSpeedButton
          Left = 0
          Top = 125
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Unavailabilities [DELETE]'
          OnClick = btnMerchantsClick
          ExplicitLeft = -16
          ExplicitTop = 106
          ExplicitWidth = 200
        end
        object btnGetUnavailabilities: TSpeedButton
          Left = 0
          Top = 100
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Unavailabilities [GET]'
          OnClick = btnGetUnavailabilitiesClick
          ExplicitLeft = -16
          ExplicitTop = 106
          ExplicitWidth = 200
        end
        object Label3: TLabel
          Left = 0
          Top = 50
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Merchant v1'
          ExplicitWidth = 105
        end
        object btnMerchantAvailability: TSpeedButton
          Left = 0
          Top = 200
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'Merchant Availability'
          OnClick = btnMerchantsClick
          ExplicitLeft = -6
          ExplicitTop = 238
        end
        object SpeedButton1: TSpeedButton
          Left = 0
          Top = 225
          Width = 241
          Height = 25
          Align = alTop
          Caption = 'ReturnMessage'
          ExplicitLeft = -6
          ExplicitTop = 272
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1326
        Height = 43
        Align = alTop
        TabOrder = 2
        object cbRestaurant: TComboBox
          Left = 1
          Top = 1
          Width = 368
          Height = 40
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = 'Selecione o restaurante'
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Delivery Much'
      ImageIndex = 1
    end
  end
end
