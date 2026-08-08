import "calendar_layout.js" as CalendarLayout
import QtQuick
import QtQuick.Layouts
import ".."
import "../Navbar/Clock"

Item {
    id: calendar
    property int monthShift: 0
    property var viewingDate: CalendarLayout.getDateInXMonthsTime(monthShift)
    property var calendarLayout: CalendarLayout.getCalendarLayout(viewingDate, monthShift === 0)
    implicitHeight: calendarColumn.implicitHeight

    Keys.onPressed: event => {
        if ((event.key === Qt.Key_PageDown || event.key === Qt.Key_PageUp) && event.modifiers === Qt.NoModifier) {
            if (event.key === Qt.Key_PageDown) {
                monthShift++;
            } else if (event.key === Qt.Key_PageUp) {
                monthShift--;
            }
            event.accepted = true;
        }
    }
    MouseArea {
        anchors.fill: parent
        onWheel: event => {
            if (event.angleDelta.y > 0) {
                monthShift--;
            } else if (event.angleDelta.y < 0) {
                monthShift++;
            }
        }
    }

    ColumnLayout {
        id: calendarColumn
        anchors.fill: parent
        Text {
            id: month
            Layout.alignment: Qt.AlignHCenter
            text: `${monthShift != 0 ? "• " : ""}${viewingDate.toLocaleDateString(Qt.locale(), "MMMM yyyy")}`
            color: Style.text
            font {
                family: Style.fontFamily
                pixelSize: Style.textSize - 2
            }
        }
        GridLayout {
            columns: calendar.calendarLayout.length + 1
            rows: calendar.calendarLayout[0].length
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 20
            Repeater {
                model: CalendarLayout.weekDays
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData.day
                    color: Style.text
                    font {
                        family: Style.fontFamily
                        bold: true
                    }
                }
            }
            Repeater {
                model: calendar.calendarLayout
                Repeater {
                    model: modelData
                    Text {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        text: modelData.day
                        color: modelData.today == -1 ? Style.inactive : modelData.today == 0 ? Style.text : Style.titleText
                        font {
                            family: Style.fontFamily
                        }
                    }
                }
            }
        }
    }
}
