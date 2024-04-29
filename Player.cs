using Godot;
using System;
using System.Reflection;

public partial class Player : CharacterBody3D
{
	[Export]
	public Camera3D camera;
	[Export]
	public float movementSpeed = 20.0f;
	[Export]
	public Node interactAgent;
	[Export]
	public NavigationAgent3D navigationAgent;

	private Vector3 targetPosition;
	private float targetRotation;
	private Vector3 targetDirection;

	private MeshInstance3D pointer;

	private bool pathing;

	private bool heldDown;

	public override void _Ready()
	{
		pointer = GetNode<MeshInstance3D>("Pointer");
	}

	public override void _PhysicsProcess(double delta)
	{
		if (camera == null || navigationAgent == null || interactAgent == null) return;

		SetMoveAndRotationTarget((float)delta);
		MoveToTarget((float)delta);
		RotateTowardsTarget((float)delta);
	}

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseButton mouseButtonEvent && mouseButtonEvent.ButtonIndex == MouseButton.Left)
		{
			heldDown = mouseButtonEvent.Pressed;
		}
	}

	private void SetMoveAndRotationTarget(float delta)
	{
		if (Input.IsActionPressed("move_to_mouse") && !interactAgent.Get("over_interactable").AsBool())
		{
			Vector3 rayOrigin = camera.ProjectRayOrigin(GetViewport().GetMousePosition());
			Vector3 rayEnd = rayOrigin + camera.ProjectRayNormal(GetViewport().GetMousePosition()) * 10000;
			Godot.Collections.Dictionary result = GetWorld3D().DirectSpaceState.IntersectRay(new PhysicsRayQueryParameters3D{From = rayOrigin, To = rayEnd, CollisionMask = 1});
			if (result.Count > 0)
			{
				var resultposition = (Vector3)result["position"];
				targetPosition = new Vector3(resultposition.X, 0, resultposition.Z);
				targetDirection = GlobalPosition.DirectionTo(targetPosition);
				targetRotation = Mathf.Atan2(targetDirection.X, targetDirection.Z);
				navigationAgent.TargetPosition=targetPosition;
				pointer.Position = targetPosition;
				pathing = true;
			}
		}
	}

	private void MoveToTarget(float delta)
	{
		if (heldDown){
			Velocity = targetDirection * movementSpeed;
			MoveAndSlide();
		}
		else{
			if (navigationAgent == null) return;
			if (pathing & GlobalPosition != targetPosition){
				Velocity = GlobalPosition.DirectionTo(navigationAgent.GetNextPathPosition()) * movementSpeed;
				MoveAndSlide();
			}
			else if (pathing & GlobalPosition == targetPosition){
				pathing = false;
			}
		}
	}

	private void RotateTowardsTarget(float delta)
	{
		if (Velocity != Vector3.Zero)
		{
			Vector2 lookDirection = new Vector2(Velocity.Z, Velocity.X);
			GlobalRotation = new Vector3(GlobalRotation.X, Mathf.LerpAngle(GlobalRotation.Y, lookDirection.Angle(), movementSpeed * delta), GlobalRotation.Z);
		}
	}
}


