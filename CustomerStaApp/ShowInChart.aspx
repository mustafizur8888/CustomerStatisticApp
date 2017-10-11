﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShowInChart.aspx.cs" Inherits="CustomerStaApp.ShowInChart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <div class="row">
        <div class="col-md-8 form-inline">
            <div class="form-group">
                <label for="txtRecency">Recency:</label>
                <input id="txtRecency" type="text" class="form-control" placeholder="Recency" />
            </div>
            <div class="form-group">
                <label for="txtFrequency">Frequency:</label>
                <input id="txtFrequency" type="text" class="form-control" placeholder="Recency" />

            </div>
            <div class="form-group">
                <label for="txtMonetary">Monetary:</label>
                <input id="txtMonetary" type="text" class="form-control" placeholder="Recency" />

            </div>
            <button class="btn btn-default" onclick="return getRegionList()">Get Region List</button>
        </div>
    </div>
    <div class="row" id="chartConfig" style="display: none">
        <div class="col-md-12">
            <div class="checkbox" id="dvCheckBoxListControl"></div>

        </div>
        <div class="col-md-12">
            <button class="btn btn-default" onclick="return getChartData()">Plot Chart</button>
        </div>
    </div>


    <div class="row">
        <div class="col-md-4 col-sm-4 col-lg-4">
            <canvas id="myChart"></canvas>
        </div>
    </div>


    <script src="Scripts/ChartJs/AppChart.js"></script>

    <script>

        var array = [];
        var Monetary = '';
        var Recency ='';
        var Frequency = '';


        function intializeValue() {
             Monetary = $('#txtMonetary').val();
             Recency = $('#txtRecency').val();
             Frequency = $('#txtFrequency').val();
        }
     


        function getRegionList() {

            intializeValue();

            console.log(Monetary);
            console.log(Recency);
            console.log(Frequency);

            $.ajax({
                url: "Handler/GetChartRegionNamehandler.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                responseType: "json",
                success: OnComplete
            });

            function OnComplete(Registration) {
                console.log(Registration);
                CreateCheckBoxList(Registration);
            }

            return false;
        }

        function CreateCheckBoxList(checkboxlistItems) {
            var table = $('<table class="table table-bordered table-condensed"></table>');
            var row = $('<tr></tr>');
            var counter = 0;
            $(checkboxlistItems).each(function () {
                var td = $('<td></td>');

                var label = $('<label class="checkbox-inline"> </label>').attr({
                    for: 'chklistitem' + counter++
                }).text(this.Region);

                var chec = $('<input>').attr({
                    type: 'checkbox',
                    name: 'chklistitem',
                    value: this.Value,
                    id: 'chklistitem' + counter,


                });

                label.prepend(chec);
                td.append(label);
                row.append(td);
            });
            table.append(row);

            $('#dvCheckBoxListControl').empty();

            $('#dvCheckBoxListControl').append(table);
            $('#chartConfig').css('display', 'block');

            //$(document).on('change', '[type=checkbox]', function () {
            //    array.push();
            //}); 

            $('label').click(function () {
                var checked = $('input', this).is(':checked');
                $('span', this).text(checked ? 'Off' : 'On');
            });


            $('#chartConfig :checkbox').click(function () {

                // array.push($(this).parent().text());

                var idx = $.inArray($(this).parent().text(), array);
                if (idx == -1) {
                    array.push( $(this).parent().text());
                } else {
                    array.splice(idx, 1);
                }
                console.log(array);
            });

          
        }
        function getChartData() {
            //$.ajax({
            //    url: "Handler/ChartData.ashx",
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    responseType: "json",
            //    success: function (data) { alert('data: ' + data); }
            //});
            intializeValue();
            console.log('click');
            $.ajax({
                url: "Handler/ChartData.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary,
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                responseType: "json",
                data: JSON.stringify(array),
                success:function(data) { alert('data: ' + data); }
            });

            return false;
        };
    </script>
</asp:Content>