import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum StatusEnum{

  process,
  approval,
  denied,
  payment,
  completed,
  cancelled,
}

String statusToString(StatusEnum status,BuildContext context) {
  switch (status) {
    case StatusEnum.process:
      return AppLocalizations.of(context).enum_process;
    case StatusEnum.approval:
      return AppLocalizations.of(context).enum_approval;
    case StatusEnum.denied:
      return AppLocalizations.of(context).enum_denied;
    case StatusEnum.payment:
      return AppLocalizations.of(context).enum_payment;
    case StatusEnum.completed:
      return AppLocalizations.of(context).enum_completed;
    case StatusEnum.cancelled:
      return AppLocalizations.of(context).enum_cancelled;
    default:
      return AppLocalizations.of(context).enum_undefined;
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

String calculateDensity(double? density,BuildContext context) {
  if (density == null) {
    return AppLocalizations.of(context).enum_no_info;
  } else if (density >= 4) {
    return AppLocalizations.of(context).enum_high;
  } else if (density >= 3) {
    return AppLocalizations.of(context).enum_medium;
  } else if (density >= 2) {
    return AppLocalizations.of(context).enum_low;
  } else if (density >= 0) {
    return AppLocalizations.of(context).enum_idle;
  } else {
    return AppLocalizations.of(context).enum_no_info;
  }
}

enum CardType {
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}