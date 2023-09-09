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

#include "backend.h"
#include <QTransform>

Backend::Backend(QObject *parent) :
    QObject(parent)
{
    connect(&m_rotation1Angle, &AnimatedParam::valueChanged, this, &Backend::rotation1AngleChanged);
    connect(&m_rotation2Angle, &AnimatedParam::valueChanged, this, &Backend::rotation2AngleChanged);
    connect(&m_rotation3Angle, &AnimatedParam::valueChanged, this, &Backend::rotation3AngleChanged);
    connect(&m_rotation4Angle, &AnimatedParam::valueChanged, this, &Backend::rotation4AngleChanged);
    connect(&m_clawsAngle, &AnimatedParam::valueChanged, this, &Backend::clawsAngleChanged);

    m_status.setBinding([this](){
        return m_isCollision.value() ? QString("Collision!") :
                                       m_rotation1Angle.isRunning()
                                        || m_rotation2Angle.isRunning()
                                        || m_rotation3Angle.isRunning()
                                        || m_rotation4Angle.isRunning()
                                        ? QString("Busy") : QString("Ready");
    });

    connect(&m_rotation1Angle, &AnimatedParam::valueChanged, this, &Backend::detectCollision);
    connect(&m_rotation2Angle, &AnimatedParam::valueChanged, this, &Backend::detectCollision);
    connect(&m_rotation3Angle, &AnimatedParam::valueChanged, this, &Backend::detectCollision);
    connect(&m_rotation4Angle, &AnimatedParam::valueChanged, this, &Backend::detectCollision);
}

int Backend::rotation1Angle() const
{
    return m_rotation1Angle.value();
}

void Backend::setRotation1Angle(const int angle)
{
    m_rotation1Angle.setValue(angle);
}

int Backend::rotation2Angle() const
{
    return m_rotation2Angle.value();
}

void Backend::setRotation2Angle(const int angle)
{
    m_rotation2Angle.setValue(angle);
}

int Backend::rotation3Angle() const
{
    return m_rotation3Angle.value();
}

void Backend::setRotation3Angle(const int angle)
{
    m_rotation3Angle.setValue(angle);
}

int Backend::rotation4Angle() const
{
    return m_rotation4Angle.value();
}

void Backend::setRotation4Angle(const int angle)
{
    m_rotation4Angle.setValue(angle);
}

int Backend::clawsAngle() const
{
    return m_clawsAngle.value();
}

void Backend::setClawsAngle(const int angle)
{
    m_clawsAngle.setValue(angle);
}

QString Backend::status() const
{
    return m_status;
}

QBindable<QString> Backend::bindableStatus() const
{
    return &m_status;
}

void Backend::detectCollision()
{
    // simple aproximate collision detection, uses hardcoded model dimensions

    QPolygon pol1(QRect(-70, 0,
                        70, 300));

    QTransform t;

    t.rotate(8.7);
    t.translate(0, 259);

    t.rotate(-20.);
    t.rotate(rotation3Angle());

    QPolygon pol2 = t.mapToPolygon(QRect(-35, 0,
                                         35, 233));
    t.translate(0, 233);
    t.rotate(15);
    t.rotate(rotation2Angle());

    QPolygon pol3 = t.mapToPolygon(QRect(-27, 0,
                                         27, 212));
    t.translate(0, 212);
    t.rotate(rotation1Angle());

    QPolygon pol4 = t.mapToPolygon(QRect(-42, 0,
                                         42, 180));

    m_isCollision.setValue(pol1.intersects(pol3)
                           || pol1.intersects(pol4)
                           || pol2.intersects(pol4));
}
