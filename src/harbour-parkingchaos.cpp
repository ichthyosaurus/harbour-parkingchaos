/*
 * This file is part of harbour-parkingchaos.
 * Copyright (C) 2020  Mirian Margiani
 *
 * harbour-parkingchaos is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * harbour-parkingchaos is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with harbour-parkingchaos.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include <sailfishapp.h>
#include <QScopedPointer>
#include <QQuickView>
#include <QtQml>
#include <QQmlContext>
#include <QGuiApplication>
#include "version.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    QQmlContext *ctxt = view.data()->rootContext();
    ctxt->setContextProperty("versionNumber", QString(APP_VERSION));
    ctxt->setContextProperty("dataDirectory", SailfishApp::pathTo("data"));

    view->setSource(SailfishApp::pathToMainQml());
    view->show();
    return app->exec();
}
