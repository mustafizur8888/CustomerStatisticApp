var ctx = document.getElementById('myChart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'horizontalBar',
    // The data for our dataset
    data: {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                label: "AAAA",
                backgroundColor: 'rgb(255, 99, 132)',
                borderColor: 'rgb(255, 99, 132)',
                data: [12, 10, 5, 2, 20, 30, 45]
            },
            {
                label: "121",
                backgroundColor: '#4EA0AB',
                borderColor: 'rgb(255, 99, 132)',
                data: [12, 10, 5, 2, 20, 30, 45]
            }
        ]
    },

    // Configuration options go here
    options: {
        scales: {
            xAxes: [{
                stacked: true
            }],
            yAxes: [{
                stacked: true
            }]
        }
    }
});