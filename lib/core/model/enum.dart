enum StatusEnum{
  process,
  approval,
  denied,
  payment,
  completed,
  cancelled,
}

String statusToString(StatusEnum status) {
  switch (status) {
    case StatusEnum.process:
      return "Process";
    case StatusEnum.approval:
      return "Approval";
    case StatusEnum.denied:
      return "Denied";
    case StatusEnum.payment:
      return "Payment";
    case StatusEnum.completed:
      return "Completed";
    case StatusEnum.cancelled:
      return "Cancelled";
    default:
      return "Undefined";
  }
}

StatusEnum statusFromString(String status) {
  switch (status) {
    case "process":
      return StatusEnum.process;
    case "approval":
      return StatusEnum.approval;
    case "denied":
      return StatusEnum.denied;
    case "cancelled":
      return StatusEnum.cancelled;
    case "payment":
      return StatusEnum.payment;
    case "completed":
      return StatusEnum.completed;
    default:
      return StatusEnum.process;
  }
}

String calculateDensity(double? density) {
  if (density == null) {
    return "No Information";
  } else if (density >= 4) {
    return "Idle";
  } else if (density >= 3) {
    return "Low";
  } else if (density >= 2) {
    return "Medium";
  } else if (density >= 0) {
    return "High";
  } else {
    return "No Information";
  }
}