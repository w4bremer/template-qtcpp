/**
NO TITLE
Copyright (C) 2020 ApiGear UG

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
#pragma once

#include <QtCore>
#include <QtPromise>

#include "../api/api.h"
#include "olink/clientnode.h"

using namespace ApiGear;
using namespace ApiGear::ObjectLink;

class OLinkSameEnum2Interface : public AbstractSameEnum2Interface, public IObjectSink
{
    Q_OBJECT
public:
    explicit OLinkSameEnum2Interface(ClientRegistry& registry, QObject *parent = nullptr);
    virtual ~OLinkSameEnum2Interface() override;

    void applyState(const nlohmann::json& fields);
    Enum1::Enum1Enum prop1() const override;
    void setProp1(const Enum1::Enum1Enum prop1) override;
    void setProp1Local(const Enum1::Enum1Enum prop1);
    Enum2::Enum2Enum prop2() const override;
    void setProp2(const Enum2::Enum2Enum prop2) override;
    void setProp2Local(const Enum2::Enum2Enum prop2);
    Enum1::Enum1Enum func1(const Enum1::Enum1Enum param1) override;
    QtPromise::QPromise<Enum1::Enum1Enum> func1Async(const Enum1::Enum1Enum param1);
    Enum1::Enum1Enum func2(const Enum1::Enum1Enum param1, const Enum2::Enum2Enum param2) override;
    QtPromise::QPromise<Enum1::Enum1Enum> func2Async(const Enum1::Enum1Enum param1, const Enum2::Enum2Enum param2);
signals:
    void isReady();
public:
    virtual std::string olinkObjectName() override;
    virtual void olinkOnSignal(std::string name, nlohmann::json args) override;
    virtual void olinkOnPropertyChanged(std::string name, nlohmann::json value) override;
    virtual void olinkOnInit(std::string name, nlohmann::json props, IClientNode *node) override;
    virtual void olinkOnRelease() override;
private:
    Enum1::Enum1Enum m_prop1;
    Enum2::Enum2Enum m_prop2;
    bool m_isReady;
    IClientNode *m_node;
    ClientRegistry& m_registry;
};
