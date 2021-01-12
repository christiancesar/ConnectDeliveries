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
  OnDestroy = FormDestroy
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
        Left = 217
        Top = 43
        Width = 1109
        Height = 818
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 232
        ExplicitWidth = 1094
      end
      object SplitView1: TSplitView
        Left = 0
        Top = 43
        Width = 217
        Height = 818
        OpenedWidth = 200
        Placement = svpLeft
        TabOrder = 1
        object btnGetToken: TSpeedButton
          Left = 0
          Top = 25
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'GetToken'
          OnClick = btnGetTokenClick
          ExplicitWidth = 200
        end
        object btnClear: TSpeedButton
          Left = 0
          Top = 788
          Width = 217
          Height = 30
          Align = alBottom
          Caption = 'Clear'
          OnClick = btnClearClick
          ExplicitTop = 793
          ExplicitWidth = 200
        end
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 217
          Height = 25
          Align = alTop
          Caption = 'Authentication'
          ExplicitWidth = 124
        end
        object Label2: TLabel
          Left = 0
          Top = 200
          Width = 217
          Height = 25
          Align = alTop
          Caption = 'Merchant v2'
          ExplicitTop = 175
          ExplicitWidth = 105
        end
        object btnMerchants: TSpeedButton
          Left = 0
          Top = 80
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Merchants [GET]'
          OnClick = btnMerchantsClick
          ExplicitWidth = 200
        end
        object btnPostUnavailabilities: TSpeedButton
          Left = 0
          Top = 170
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Unavailabilities [POST]'
          OnClick = btnPostUnavailabilitiesClick
          ExplicitWidth = 200
        end
        object btnDeleteUnavailabilities: TSpeedButton
          Left = 0
          Top = 140
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Unavailabilities [DELETE]'
          OnClick = btnDeleteUnavailabilitiesClick
          ExplicitTop = 125
          ExplicitWidth = 200
        end
        object btnGetUnavailabilities: TSpeedButton
          Left = 0
          Top = 110
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Unavailabilities [GET]'
          OnClick = btnGetUnavailabilitiesClick
          ExplicitTop = 105
          ExplicitWidth = 200
        end
        object Label3: TLabel
          Left = 0
          Top = 55
          Width = 217
          Height = 25
          Align = alTop
          Caption = 'Merchant v1'
          ExplicitTop = 50
          ExplicitWidth = 105
        end
        object btnMerchantAvailability: TSpeedButton
          Left = 0
          Top = 225
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Merchant Availability'
          OnClick = btnMerchantAvailabilityClick
          ExplicitTop = 215
          ExplicitWidth = 200
        end
        object btnPolling: TSpeedButton
          Left = 0
          Top = 280
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Polling(Request in 30s)'
          ExplicitTop = 275
          ExplicitWidth = 200
        end
        object BtnAcknow: TSpeedButton
          Left = 0
          Top = 310
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Acknowledgment'
          ExplicitTop = 275
          ExplicitWidth = 200
        end
        object btnDispatch: TSpeedButton
          Left = 0
          Top = 430
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Dispatch'
          ExplicitTop = 390
          ExplicitWidth = 200
        end
        object btnConfirmation: TSpeedButton
          Left = 0
          Top = 400
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Confirmation'
          ExplicitTop = 355
          ExplicitWidth = 200
        end
        object btnIntegration: TSpeedButton
          Left = 0
          Top = 370
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'Integration'
          ExplicitTop = 345
          ExplicitWidth = 200
        end
        object btnOrderDetail: TSpeedButton
          Left = 0
          Top = 340
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'OrderDetail'
          ExplicitTop = 330
          ExplicitWidth = 200
        end
        object Label5: TLabel
          Left = 0
          Top = 255
          Width = 217
          Height = 25
          Align = alTop
          Caption = 'Order v3'
          ExplicitTop = 225
          ExplicitWidth = 73
        end
        object btnCancellationDenied: TSpeedButton
          Left = 0
          Top = 550
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'CancellationDenied'
          ExplicitTop = 485
          ExplicitWidth = 200
        end
        object btnCancellationRequest: TSpeedButton
          Left = 0
          Top = 490
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'CancellationRequested'
          ExplicitTop = 430
          ExplicitWidth = 200
        end
        object btnReadyDelivery: TSpeedButton
          Left = 0
          Top = 460
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'ReadyToDelivery'
          ExplicitWidth = 200
        end
        object btnCancellationAccepted: TSpeedButton
          Left = 0
          Top = 520
          Width = 217
          Height = 30
          Align = alTop
          Caption = 'CancellationAccepted'
          ExplicitTop = 455
          ExplicitWidth = 200
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
        object tsStatus: TToggleSwitch
          Left = 1232
          Top = 1
          Width = 93
          Height = 41
          Align = alRight
          Color = clWhite
          FrameColor = clBlack
          ReadOnly = True
          TabOrder = 1
          ThumbColor = clHotLight
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Delivery Much'
      ImageIndex = 1
    end
  end
end
