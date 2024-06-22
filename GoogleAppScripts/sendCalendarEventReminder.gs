// A simple Google App Script Program that will send an email reminder to all confirmed guests.
// Each attendees will only receive a one time email reminder. 
// If an event guest confirmed after this script has executed, the next time you execute this script only that user will be able to receive the emaail reminder.

function sendEmailReminder() {
  var calendar = CalendarApp.getDefaultCalendar();
  var today = new Date();
  var tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);
  tomorrow.setHours(0, 0, 0, 0);
  var dayAfterTomorrow = new Date(tomorrow);
  dayAfterTomorrow.setDate(tomorrow.getDate() + 1);
  dayAfterTomorrow.setHours(0, 0, 0, 0);

  var events = calendar.getEvents(tomorrow, dayAfterTomorrow, { search: 'Weekly Team Meeting' });

  events.forEach(function(event) {
    var guests = event.getGuestList();
    var startTime = event.getStartTime();

    guests.forEach(function(guest) {
      var guestEmail = guest.getEmail();
      var guestProperty = event.getId() + "_" + guestEmail;
      var emailSent = PropertiesService.getScriptProperties().getProperty(guestProperty);

      if (!emailSent && guestEmail && guest.getGuestStatus() == 'YES') {

        MailApp.sendEmail(guestEmail, 
          'Reminder: Fire Drill Event Tomorrow' + startTime, 
          'Hi\n\nAre you prepared for the meeting tomorrow?');

        // Mark this guest as emailed for this event
        PropertiesService.getScriptProperties().setProperty(guestProperty, 'true');
      }
    });
  });
}
