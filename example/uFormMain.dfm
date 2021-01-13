object FormMain: TFormMain
  Left = 0
  Top = 0
  ActiveControl = PageControl1
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
  object SpeedButton1: TSpeedButton
    Left = 488
    Top = 440
    Width = 23
    Height = 22
  end
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
      object SplitView1: TSplitView
        Left = 0
        Top = 43
        Width = 200
        Height = 661
        OpenedWidth = 200
        Placement = svpLeft
        TabOrder = 0
        ExplicitHeight = 674
        object ScrollBox1: TScrollBox
          Left = 0
          Top = 0
          Width = 200
          Height = 661
          Align = alLeft
          TabOrder = 0
          ExplicitHeight = 693
          object BtnAcknow: TSpeedButton
            Left = 0
            Top = 310
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Acknowledgment'
            ExplicitTop = 275
            ExplicitWidth = 200
          end
          object btnCancellationAccepted: TSpeedButton
            Left = 0
            Top = 550
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'CancellationAccepted'
            OnClick = btnCancellationAcceptedClick
            ExplicitTop = 7
            ExplicitWidth = 164
          end
          object btnCancellationDenied: TSpeedButton
            Left = 0
            Top = 520
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'CancellationDenied'
            OnClick = btnCancellationDeniedClick
            ExplicitTop = 7
            ExplicitWidth = 164
          end
          object btnCancellationRequest: TSpeedButton
            Left = 0
            Top = 490
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'CancellationRequested'
            OnClick = btnCancellationRequestClick
            ExplicitTop = 7
            ExplicitWidth = 164
          end
          object btnClear: TSpeedButton
            Left = 0
            Top = 627
            Width = 196
            Height = 30
            Align = alBottom
            Caption = 'Clear'
            OnClick = btnClearClick
            ExplicitTop = 7
            ExplicitWidth = 164
          end
          object btnConfirmation: TSpeedButton
            Left = 0
            Top = 400
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Confirmation'
            OnClick = btnConfirmationClick
            ExplicitLeft = 3
            ExplicitTop = 394
          end
          object btnDeleteUnavailabilities: TSpeedButton
            Left = 0
            Top = 140
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Unavailabilities [DELETE]'
            OnClick = btnDeleteUnavailabilitiesClick
            ExplicitLeft = 3
            ExplicitTop = 116
          end
          object btnDispatch: TSpeedButton
            Left = 0
            Top = 430
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Dispatch'
            OnClick = btnDispatchClick
            ExplicitLeft = 3
            ExplicitTop = 420
          end
          object btnGetToken: TSpeedButton
            Left = 0
            Top = 25
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'GetToken'
            OnClick = btnGetTokenClick
            ExplicitLeft = 3
            ExplicitTop = 2
          end
          object btnGetUnavailabilities: TSpeedButton
            Left = 0
            Top = 110
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Unavailabilities [GET]'
            OnClick = btnGetUnavailabilitiesClick
            ExplicitLeft = 16
            ExplicitTop = 99
          end
          object btnIntegration: TSpeedButton
            Left = 0
            Top = 370
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Integration'
            OnClick = btnIntegrationClick
            ExplicitLeft = 3
            ExplicitTop = 359
          end
          object btnMerchantAvailability: TSpeedButton
            Left = 0
            Top = 225
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Merchant Availability'
            OnClick = btnMerchantAvailabilityClick
            ExplicitLeft = 3
            ExplicitTop = 86
          end
          object btnMerchants: TSpeedButton
            Left = 0
            Top = 80
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Merchants [GET]'
            OnClick = btnMerchantsClick
            ExplicitLeft = -3
            ExplicitTop = 69
          end
          object btnOrderDetail: TSpeedButton
            Left = 0
            Top = 340
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'OrderDetail'
            OnClick = btnOrderDetailClick
            ExplicitLeft = 16
            ExplicitTop = 214
          end
          object btnPolling: TSpeedButton
            Left = 0
            Top = 280
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Polling'
            Transparent = False
            OnClick = btnPollingClick
            ExplicitLeft = 16
            ExplicitTop = 141
          end
          object btnPostUnavailabilities: TSpeedButton
            Left = 0
            Top = 170
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'Unavailabilities [POST]'
            OnClick = btnPostUnavailabilitiesClick
            ExplicitLeft = 3
            ExplicitTop = 159
          end
          object btnReadyDelivery: TSpeedButton
            Left = 0
            Top = 460
            Width = 196
            Height = 30
            Align = alTop
            Caption = 'ReadyToDelivery'
            OnClick = btnReadyDeliveryClick
            ExplicitTop = 7
            ExplicitWidth = 164
          end
          object Label1: TLabel
            Left = 0
            Top = 0
            Width = 196
            Height = 25
            Align = alTop
            Caption = 'Authentication'
            ExplicitLeft = 16
            ExplicitTop = -8
          end
          object Label2: TLabel
            Left = 0
            Top = 200
            Width = 196
            Height = 25
            Align = alTop
            Caption = 'Merchant v2'
            ExplicitTop = 12
            ExplicitWidth = 164
          end
          object Label3: TLabel
            Left = 0
            Top = 55
            Width = 196
            Height = 25
            Align = alTop
            Caption = 'Merchant v1'
            ExplicitWidth = 105
          end
          object Label5: TLabel
            Left = 0
            Top = 255
            Width = 196
            Height = 25
            Align = alTop
            Caption = 'Order v3'
            ExplicitLeft = -3
            ExplicitTop = 111
          end
        end
      end
      object pLog: TPanel
        Left = 0
        Top = 704
        Width = 1326
        Height = 157
        Align = alBottom
        Caption = 'pLog'
        TabOrder = 1
        object Memo1: TMemo
          Left = 1
          Top = 1
          Width = 1324
          Height = 155
          Align = alClient
          Color = clWhite
          ScrollBars = ssVertical
          TabOrder = 0
          ExplicitTop = 4
          ExplicitHeight = 120
        end
      end
      object pPrincipal: TPanel
        Left = 200
        Top = 43
        Width = 1126
        Height = 661
        Align = alClient
        TabOrder = 2
        ExplicitLeft = 204
        ExplicitTop = 47
        ExplicitHeight = 693
        object DBGrid1: TDBGrid
          Left = 1
          Top = 1
          Width = 1124
          Height = 659
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsPolling
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -19
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object pHeader: TPanel
        Left = 0
        Top = 0
        Width = 1326
        Height = 43
        Align = alTop
        TabOrder = 3
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 1124
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
          Left = 1243
          Top = 1
          Width = 82
          Height = 41
          Align = alRight
          Color = clWhite
          FrameColor = clBlack
          ReadOnly = True
          TabOrder = 1
          ThumbColor = clHotLight
          ExplicitLeft = 1041
          ExplicitHeight = 27
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Delivery Much'
      ImageIndex = 1
    end
  end
  object dsPolling: TDataSource
    AutoEdit = False
    DataSet = cdsPolling
    Left = 656
    Top = 448
  end
  object cdsPolling: TClientDataSet
    PersistDataPacket.Data = {
      8A0000009619E0BD0100000018000000040000000000030000008A0004636F64
      6501004900000001000557494454480200020064000D636F7272656C6174696F
      6E49640100490000000100055749445448020002006400096372656174656441
      7401004900000001000557494454480200020064000269640100490000000100
      0557494454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 416
    object cdsPollingcode: TStringField
      DisplayWidth = 30
      FieldName = 'code'
      Size = 100
    end
    object cdsPollingcorrelationId: TStringField
      DisplayWidth = 39
      FieldName = 'correlationId'
      Size = 100
    end
    object cdsPollingcreatedAt: TStringField
      DisplayWidth = 22
      FieldName = 'createdAt'
      Size = 100
    end
    object cdsPollingid: TStringField
      DisplayWidth = 35
      FieldName = 'id'
      Size = 100
    end
  end
end
