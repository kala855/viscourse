
#include <vtkVersion.h>
#include <vtkSmartPointer.h>
#include <vtkProperty.h>
#include <vtkTable.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkRenderer.h>
#include <vtkVertexGlyphFilter.h>
#include <vtkContextView.h>
#include <vtkContextScene.h>
#include <vtkPlot.h>
#include <vtkChartXY.h>
#include <vtkAxis.h>
#include <vtkDelimitedTextReader.h>
#include <vtkDoubleArray.h>
#include <vtkStringArray.h>
#include <math.h>

#define VTK_CREATE(type, name) \
    vtkSmartPointer<type> name = vtkSmartPointer<type>::New()

static const char *labels[] = {"AeroBacter","Bru. Abortus","Bru. Anthra","Diplococcus",
    "E. Coli","Klebsiella","MycoBacterium","Proteus","Pseudomonas","Salmonella","Salmo. Schott",
    "Staphy. Albus","Staphy. Aure","Strepto. Feca","Strepto. Hemo","Strepto. Viri"};

int main(int argc, char* argv[])
{
  // Verify input arguments
  if(argc != 2)
    {
    std::cout << "Usage: " << argv[0]
              << " Filename(.csv)" << std::endl;
    return EXIT_FAILURE;
    }

  std::string inputFilename = argv[1];


  VTK_CREATE(vtkContextView,view);
  view->GetRenderer()->SetBackground(1.0,1.0,1.0);
  view->GetRenderWindow()->SetSize(800,600);
  VTK_CREATE(vtkChartXY, chart);
  view->GetScene()->AddItem(chart);

  VTK_CREATE(vtkDelimitedTextReader,reader);
  reader->SetFileName(inputFilename.c_str());
  reader->DetectNumericColumnsOn();
  reader->SetFieldDelimiterCharacters(",");
  reader->SetHaveHeaders(true);
  reader->Update();

  vtkTable* table = reader->GetOutput();

  std::cout << "Table has " << table->GetNumberOfRows()
            << " rows." << std::endl;
  std::cout << "Table has " << table->GetNumberOfColumns()
            << " columns." << std::endl;

  VTK_CREATE(vtkDoubleArray, arrXTickPositions);
  arrXTickPositions->SetNumberOfValues(table->GetNumberOfRows());

  VTK_CREATE(vtkStringArray, stringLabels);
  stringLabels->SetNumberOfValues(table->GetNumberOfRows());

  for(vtkIdType i = 0; i < table->GetNumberOfRows(); i++)
    {
    std::cout <<"Data:" << (table->GetValue(i,0)).ToDouble()
              <<" Penicillin:" << (table->GetValue(i,1)).ToDouble()
              <<" Streptomycin:" << (table->GetValue(i,2)).ToDouble()
              <<" Neomycin:" << (table->GetValue(i,3)).ToDouble()
              <<" Gram Staining:" << (table->GetValue(i,4)).ToDouble()
              << endl;
        arrXTickPositions->SetValue(i,i+1);
        stringLabels->SetValue(i,labels[i]);
        table->SetValue(i,1,vtkVariant(8.0+log(table->GetValue(i,1).ToDouble())));
        table->SetValue(i,2,vtkVariant(8.0+log(table->GetValue(i,2).ToDouble())));
        table->SetValue(i,3,vtkVariant(8.0+log(table->GetValue(i,3).ToDouble())));
    }

  vtkPlot *line = 0;
  chart->GetAxis(1)->SetTickLabels(stringLabels);
  chart->GetAxis(1)->SetTickPositions(arrXTickPositions);
  chart->SetShowLegend(true);
  chart->SetTitle("Minimum Inhibitory Concentration");

  line = chart->AddPlot(vtkChart::BAR);
  line->SetInputData(table,0,1);
  line->SetColor(100,200,25,255);

  line = chart->AddPlot(vtkChart::BAR);
  line->SetInputData(table,0,2);
  line->SetColor(10,50,25,255);

  line = chart->AddPlot(vtkChart::BAR);
  line->SetInputData(table,0,3);
  line->SetColor(10,50,250,255);

  view->GetRenderWindow()->SetMultiSamples(0);
  view->GetInteractor()->Initialize();
  view->GetInteractor()->Start();

  return EXIT_SUCCESS;
}
