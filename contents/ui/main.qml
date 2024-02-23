import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami
PlasmoidItem {
    property real timeout: 3600 * 1000
    property string currentText: "%y% is %p%%complete"
    property real currentPercent: 0.0
    readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()
    readonly property string currentYear: currentDateTime.getFullYear()
    property string customLabel: plasmoid.configuration.customLabel
    property date prevDateTime
    Layout.minimumWidth: plasmoid.configuration.labelFontSize * customLabel.length
    width: 365
    height: 100


    function isLeapYear(year) {
        return !(year % 100 ? year % 4 : year % 400);
    }

    function milliseconds_to_days(ms) {
        return Math.floor(ms/ (1000 * 3600 * 24));
    }

    function calculatePercentage(first_date, second_date)
    {
        // console.log("Calculating percentage: " + first_date.toDateString() + " : " + second_date.toDateString());

        var days_in_year = 365;
        if(isLeapYear(currentYear))
        {
            // console.log("Year: " + currentYear + " is a leap year!")
            days_in_year = 366;
        }

        var milliseconds_elapsed = Math.abs(second_date.getTime() - first_date.getTime());
        var days_elapsed = milliseconds_to_days(milliseconds_elapsed);

        console.log("Days since: " + first_date.toDateString() + " -> " + days_elapsed + " (total:" + days_in_year + ")");

        var result_percentage = 0.0;
        if(days_elapsed <= days_in_year)
        {
            result_percentage = (days_elapsed/days_in_year) * 100;
        }

        console.log(currentYear + " is " + result_percentage.toFixed(2)  + "% complete");
        return result_percentage.toFixed(1);
    }

    function checkDate() {
        var today = new Date();
        var first_day_of_year = new Date(currentYear, 0, 1);
        currentPercent = calculatePercentage(first_day_of_year, today);
        currentText = customLabel.replace(/%y%/g, currentYear).replace(/%p%/g, currentPercent+'%');
    }

    Plasma5Support.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: timeout
        intervalAlignment: PlasmaCore.Types.AlignToHour
    }

    onCurrentDateTimeChanged: {
        // console.log("onCurrentDateTimeChanged " +  currentDateTime + ", day changed from " + prevDateTime.getDay() + " to " + currentDateTime.getDay());
        prevDateTime = currentDateTime;
        checkDate();
    }

    onCustomLabelChanged: checkDate();

    fullRepresentation: Item {
        anchors.fill: parent
        // spacing: 0
        Label {
            id: percentageLabel
            z: 1
            anchors.centerIn: parent
            text: currentText
            font.pointSize: plasmoid.configuration.labelFontSize
        }
        // ProgressBar {
        //     id: progressBar
        //     implicitWidth: 300
        //     Layout.alignment: Qt.AlignCenter
        //     value: currentPercent
        //     to: 100
        //     from: 0
        // }
        Rectangle {
            id: progressBar
            anchors.left: parent.left
            height: parent.height
            width: (currentPercent/100) * parent.width
            z: 0
            color: Kirigami.Theme.highlightColor
        }
    }
    Component.onCompleted:
    {
        prevDateTime = currentDateTime
        checkDate();
    }
}
