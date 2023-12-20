/*
 *   Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.8
import QtQuick.Layouts 1.1

import org.kde.plasma.core 2.0
import org.kde.plasma.components 2.0

ColumnLayout {
    // ColumnLayout {
        Label {
            text: {
                var currentTime = new Date(timeSource.data["Local"]["DateTime"]);
                var hours = currentTime.getHours();
                if (hours > 12) {
                    hours -= 12;
                }
                return hours.toString().padStart(2, '0') + ":" + currentTime.getMinutes().toString().padStart(2, '0');
            }
            color: "#dfdfdf"
            font.pointSize: 100
            font.weight: Font.Bold
            Layout.alignment: Qt.AlignHCenter
            renderType: Text.QtRendering
        }
    
        Label {
            // text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)
            text: Qt.formatDate(timeSource.data["Local"]["DateTime"], "dddd, MMMM dd")
            color: "#dfdfdf"
            font.pointSize: 24
            font.weight: Font.Light
            Layout.alignment: Qt.AlignHCenter
        }
    // }
    // Rectangle {
    //     z:-1
    //     ColumnLayout {
    //         anchors.top: parent.top
    //         spacing: 8
    //         Label {
    //             text: Qt.formatTime(timeSource.data["Local"]["DateTime"])
    //             color: "#5657f5"
    //             font.pointSize: 44
    //             font.weight: Font.Bold
    //             Layout.alignment: Qt.AlignHCenter
    //             renderType: Text.QtRendering
    //         }
    //         Label {
    //             text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)
    //             color: "#5657f5"
    //             font.pointSize: 20
    //             font.weight: Font.Bold
    //             Layout.alignment: Qt.AlignHCenter
    //         }
    //     }
    // }
    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000
    }
}

