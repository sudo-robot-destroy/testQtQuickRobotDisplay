/****************************************************************************
**
** Copyright (C) 2022 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Design Studio.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#pragma once

#include <QObject>
#include <qqmlregistration.h>
#include "animatedparam.h"

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int rotation1Angle READ rotation1Angle WRITE setRotation1Angle NOTIFY rotation1AngleChanged)
    Q_PROPERTY(int rotation2Angle READ rotation2Angle WRITE setRotation2Angle NOTIFY rotation2AngleChanged)
    Q_PROPERTY(int rotation3Angle READ rotation3Angle WRITE setRotation3Angle NOTIFY rotation3AngleChanged)
    Q_PROPERTY(int rotation4Angle READ rotation4Angle WRITE setRotation4Angle NOTIFY rotation4AngleChanged)
    Q_PROPERTY(int clawsAngle READ clawsAngle WRITE setClawsAngle NOTIFY clawsAngleChanged)
    Q_PROPERTY(QString status READ status BINDABLE bindableStatus)

public:
    explicit Backend(QObject *parent = nullptr);

    int rotation1Angle() const;
    void setRotation1Angle(const int angle);

    int rotation2Angle() const;
    void setRotation2Angle(const int angle);

    int rotation3Angle() const;
    void setRotation3Angle(const int angle);

    int rotation4Angle() const;
    void setRotation4Angle(const int angle);

    int clawsAngle() const;
    void setClawsAngle(const int angle);

    QString status() const;
    QBindable<QString> bindableStatus() const;

signals:
    void rotation1AngleChanged();
    void rotation2AngleChanged();
    void rotation3AngleChanged();
    void rotation4AngleChanged();
    void clawsAngleChanged();

private:
    AnimatedParam m_rotation1Angle;
    AnimatedParam m_rotation2Angle;
    AnimatedParam m_rotation3Angle;
    AnimatedParam m_rotation4Angle;
    AnimatedParam m_clawsAngle;

    QProperty<QString> m_status;
    QProperty<bool> m_isCollision;

    void detectCollision();
};
