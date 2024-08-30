unit GameViewSomething;

interface

uses Classes,
  CastleVectors, CastleUIControls, CastleControls, CastleKeysMouse,
  CastleLog;

type
  TViewSomething = class(TCastleView)
  published
    { Components designed using CGE editor.
      These fields will be automatically initialized at Start. }
    // ButtonXxx: TCastleButton;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Start; override;
    procedure Update(const SecondsPassed: Single; var HandleInput: boolean); override;
  end;

var
  ViewSomething: TViewSomething;

implementation

PlayerManager.HandleInput(Event);

constructor TViewSomething.Create(AOwner: TComponent);
begin
  inherited;
  DesignUrl := 'castle-data:/gameviewsomething.castle-user-interface';
end;

procedure TViewSomething.Start;
begin
  inherited;
  { Executed once when view starts. }
  CastleLog.WritelnLog('Weszlo');
end;

procedure TViewSomething.Update(const SecondsPassed: Single; var HandleInput: boolean);
begin
  inherited;
  { Executed every frame. }
  CastleLog.WritelnLog('Weszlo');
end;

end.
