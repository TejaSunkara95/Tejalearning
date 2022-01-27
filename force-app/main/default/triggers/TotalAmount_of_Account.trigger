trigger TotalAmount_of_Account on Contact (after insert,after update,after delete) {
    ContactTrigger.amountField(Trigger.new, Trigger.old, Trigger.oldmap);
}